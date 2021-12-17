#define N 3         // Number of waiting room chairs
#define BARBER 0    // The barber is numbered by his pid = 0
#define C 4         // Customers will be numbered from 1 to C
mtype={done,unattended};

byte queue[N];
byte start=0,end=0,customers=0;
#define next(x) ((x+1)%N)

byte sitting = BARBER; // The person sitting in the barberchair

mtype shaved[C+1];      // Which persons have been shaved (0 not used: the barber)

byte freeseats = N;
bool mutex = true;
bool ready = true;

inline waitI(sem) { 
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
    ::  true -> 
                waitI(customers)
                waitB(mutex)
working:        freeseats++
                sitting=queue[start]
                shaved[sitting]= done
                start=next(start)
                printf("Shave\n")
                signalB(ready)
                signalB(mutex)
    od
}

active [C] proctype Customer() {
  do
  ::    waitB(mutex)
        if
        :: freeseats > 0 -> 
                    freeseats--
                    shaved[_pid] = unattended
                    queue[end]=_pid
                    printf("Pre-next %d\n", end)
                    end=next(end)
                    printf("Post-next %d\n", end)
waiting:            printf("%d Waiting room\n",_pid)
                    signalI(customers)
                    signalB(mutex)
                    waitB(ready)
attended:           shaved[_pid] == done

        :: freeseats == 0 ->
leftUnattended:     printf("%d Skipped, no room\n", _pid)
                    signalB(mutex)
                    skip
        fi
  od
}