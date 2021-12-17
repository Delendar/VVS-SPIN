#define N 1         // Number of waiting room chairs
#define BARBER 0    // The barber is numbered by his pid = 0
#define C 4         // Customers will be numbered from 1 to C
mtype={done,unattended};

byte queue[N];
byte start=0,end=0,customers=0;
#define next(x) ((x+1)%N)

byte sitting = BARBER; // The person sitting in the barberchair

mtype shaved[C+1];      // Which persons have been shaved (0 not used: the barber)

active proctype Barber() {
  do
  :: sitting!=BARBER ->
      printf("%d is being shaved\n",sitting);
      shaved[sitting]=done;                  // done
      if
      :: customers>0  -> sitting=queue[start]; // sit next customer
                         start=next(start)     // removing from queue
		         customers--
              
      :: customers==0 -> sitting=BARBER;       // no one waiting, sleep again  
sleeping:          printf("Barber sleeping\n")
      fi
  od
}

active [C] proctype Customer() {
  do
  ::  printf("%d arrives\n",_pid);
      shaved[_pid]=unattended   // I start unshaved
      if
                                        // mutex lock
      :: sitting==BARBER -> sitting = _pid;      // I directly sit in the chair
waiting:		            shaved[_pid]==done   // wait until being shaved
                                        // mutex unlock
                                        // mutex lock
      :: sitting!=BARBER && customers<N ->
                   queue[end]=_pid;     // I enter the waiting queue
                   end=next(end);       
            customers++;     
		    shaved[_pid]==done   // wait until being shaved
      :: sitting!=BARBER && customers==N ->
leftUnattended:                   skip
      fi;
  leave:    printf("%d left %e\n",_pid,shaved[_pid])
  od
}