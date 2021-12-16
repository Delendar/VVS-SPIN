bool mutex = true;

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
        printf("Critical section P\n");
        signal(mutex);
}

active proctype Q() {
    do
    ::  printf("Non-critical section P\n");
        wait(mutex);
cs:     printf("Critical section P\n");
        signal(mutex);
}