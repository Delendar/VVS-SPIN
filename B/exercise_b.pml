#define N 1         // Number of waiting room chairs
#define BARBER 0    // The barber is numbered by his pid = 0
#define C 4         // Customers will be numbered from 1 to C
mtype={done,unattended};

byte queue[N];
byte start=0,end=0,customers=0;
#define next(x) ((x+1)%N)

byte sitting = BARBER; // The person sitting in the barberchair

mtype shaved[C+1];      // Which persons have been shaved (0 not used: the barber)

int freeseats = N;
bool mutex = true;
bool ready = true;

inline waitI(sem) { // macro definition
    atomic {
        sem>0;
        sem--
    }
}
inline signalI(sem) {
    sem++
}

inline waitB(sem) { // macro definition
    atomic {
        sem;
        sem=false
    }
}
inline signalB(sem) {
    sem=true
}

active proctype Barber() {
  do
  :: sitting!=BARBER ->
      printf("%d is being shaved\n",sitting);
      waitB(ready);
      shaved[sitting]=done;                  // done
      if
      :: customers>0  -> waitI(customer);
                         sitting=queue[start]; // sit next customer
                         start=next(start)     // removing from queue
		                 customers--
                         signalI(customer);
                         signalB(ready);
      :: customers==0 -> sitting=BARBER;       // no one waiting, sleep again  
                   signalB(ready);
sleeping:          printf("Barber sleeping\n")
      fi
  od
}

active [C] proctype Customer() {
  do
  ::  printf("%d arrives\n",_pid);
      shaved[_pid]=unattended   // I start unshaved
      waitB(mutex);
      if
                                        // mutex lock
      :: sitting==BARBER -> sitting = _pid;      // I directly sit in the chair
waiting:		            shaved[_pid]==done   // wait until being shaved
                            signal(mutex);           // mutex unlock
                                        // mutex lock
      :: sitting!=BARBER && customers<N ->
                    queue[end]=_pid;     // I enter the waiting queue
                    end=next(end);       // mutex lock
                    customers++;     
                    shaved[_pid]==done   // wait until being shaved
                    signal(mutex);      
      :: sitting!=BARBER && customers==N ->
                    signal(mutex);
leftUnattended:     skip
      fi;
  leave:    printf("%d left %e\n",_pid,shaved[_pid])
  od
}

active proctype Barber() {
    do
    :: waitI(customers);
       waitB(mutex);
       freeseats++;
       printf("%d is being shaved\n",sitting);
       shaved[sitting]=done; 
       sitting=queue[start];
       start=next(start)
       signalB(mutex);
       signalB(ready);
    od
}

active [C] proctype Customer() {
  do
  ::    waitB(mutex);
        if
        :: freeseats > 0 -> 
            shaved[_pid]=unattended
            freeseats--;
            signalI(customers);
            signalB(mutex);
            waitB(ready);
            sitting = _pid;
            shaved[_pid]==done
        :: freeseats == 0 ->
            signalB(mutex);
            skip
        fi
  od
}