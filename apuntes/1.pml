bool mutex = true;
int critical = 0;

inline wait(s) {
    atomic {
        s;
        s=false;
    }
}

inline signal(s) {
    s=true;
}

active proctype P() {
    do
    ::  printf("Non-critical section P\n");
        wait(mutex);
        critical++;
        printf("Critical section P\n");
        critical--;
        signal(mutex);
}

active proctype Q() {
    do
    ::  printf("Non-critical section P\n");
        wait(mutex);
cs:     printf("Critical section P\n");
        signal(mutex);
}