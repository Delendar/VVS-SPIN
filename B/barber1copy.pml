#define N 2         // Number of waiting room chairs
#define BARBER 0    // The barber is numbered by his pid = 0
#define C 4         // Customers will be numbered from 1 to C
mtype={done,unattended};

byte queue[N];
byte start=0,end=0;
#define next(x) ((x+1)%N)

byte sitting = BARBER; // The person sitting in the barberchair

int clientes = 0;
int freeseats = N;
bool mutex = true;
bool ready = true;

mtype shaved[C+1];      // Which persons have been shaved (0 not used: the barber)


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
    printf("Barber starts\n");
    do
    ::  true -> 
                printf("Barber will wait for customers\n")
                printf("Pre-Customers\n")
                printf("Customers: %d\n", clientes)
                printf("Post-customers\n")
                if
                :: clientes != 0 ->
                            printf("Barber has customers\n");
                            waitB(mutex);
                            printf("B: Mutex locked\n");
working:                    freeseats++;
                            sitting=queue[start];
                            shaved[sitting]= done;
                            start=next(start);
                            printf("%d is being shaved\n",sitting);
                            printf("Barber is ready\n");
                            signalB(ready);
                            printf("B: mutex freed\n");
                            signalB(mutex);
                fi
    
    od
}

active [C] proctype Customer() {
  do
  ::    waitB(mutex);
        if
        :: freeseats > 0 -> 
            freeseats--;
            shaved[_pid] = unattended;
            queue[end]=_pid;
            end=next(end);
waiting:    printf("%d Waiting room\n",_pid);
            printf("Customers: %d\n", clientes);
            clientes++;
            printf("Customers++\n");
            printf("Customers: %d\n", clientes);
            signalB(mutex);
            printf("Mutex Free\n");
            printf("Will wait for free barber\n");
            waitB(ready);
attended:   shaved[_pid] == done

        :: freeseats == 0 ->
leftUnattended:     printf("%d Skipped, no room\n", _pid);
                    signalB(mutex);
            skip
        fi
  od
}