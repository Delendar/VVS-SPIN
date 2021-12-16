proctype P (byte c; int n) {
    printf("Executing process %c (%d)\n", c, n);
    count = count + 1;
}

active proctype P() {
    byte i=0;
    do
    ::  if
        :: i<4 ->   i++;
        :: i==2 ->  i++;
cs:                 printf("seccion critica %d\n", i);
        :: i==4 ->  i=0;
        fi;
        printf("seccion no critica %d\n", i);
}
// spin -a -f '!<>(P@cs)'
// gcc -o pan pan.c
// pan -a -f                Esto busca en ejemplos infinitos
// spin -p -t -l clase.pml  Traza de spin
// P[X]@cs                  Para saber solo de un cierto proceso, X es numero de proceso
init {
    printf("Starting...\n");
    run P('A', 100);
    run P('B', 230);
    _nr_pr==1;
    printf("All process terminated\n");
}