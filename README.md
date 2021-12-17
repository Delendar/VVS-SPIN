# VVS-SPIN
Prácticas para Validación y Verificación del Software. Apartado de Promela-Spin

# Notas sobre la practica :
Spin barber0.pml  -- porque se da timeout?

Entregar un informe, enseñar el codigo, enseñar el comando de spin

Lo que muestra pan, si es 0 errores se muestra que no hay errores porque tata

Da error, "en la traza se puede ver que el cliente entra antes que el 2... blablabla"

2 puntos de la asignatura

Un .zip, con barber0 y barber1.pml y un pdf con el informe

# Exercise A :
``` text
Using the naive approach code, force Spin to obtain counterexamples of the following (safety) properties:
 1. The barber cannot be sleeping while there are customers waiting.
 2. Any customer (take, for instance, 1) should never leave unattended while the barber is sleeping.
```
 Para el apartado 1 necesitamos comprobar que tanto el proceso del barbero como los clientes no se encuentran en cierto punto en el mismo instante, los puntos los indicamos de la siguiente forma :
``` c++
active proctype Barber() {
  do
  :: sitting!=BARBER ->
      printf("%d is being shaved\n",sitting);
      shaved[sitting]=done;                  
      if
      :: customers>0  -> sitting=queue[start]; 
                         start=next(start)     
		                 customers--
              
      :: customers==0 -> sitting=BARBER;        
sleeping:          
      printf("Barber sleeping\n")
      fi
  od
}
```
De esta forma dejamos indicado el punto en donde se identifica al "barbero durmiendo". Lo marcamos con la etiqueta: _`sleeping`_.
``` c++
active [C] proctype Customer() {
  do
  ::  printf("%d arrives\n",_pid);
      shaved[_pid]=unattended   
      if
                                        
      :: sitting==BARBER -> sitting = _pid;
waiting:		      shaved[_pid]==done   

      :: sitting!=BARBER && customers<N ->
                  queue[end]=_pid;     
                  end=next(end);       
                  customers++;     

		              shaved[_pid]==done   
leftUnattended:    skip
      fi;
  leave:    printf("%d left %e\n",_pid,shaved[_pid])
  od
}
```
Dejamos indicado el punto en donde se debe de encontrar el proceso del cliente cuando este esta esperando. Marcado con la etiqueta: _`waiting`_.

Para esto se debe de cumplir que en ningun instante de tiempo, las dos condiciones _`sleeping`_ y _`waiting`_ van a estar activas, entonces :
 - []!(Barber@sleeping && Customer@waiting)

Para verificar esto con Spin hemos de negar el predicado :
 - ![]!(Barber@sleeping && Customer@waiting)

```` c++
$ spin -t -p barber.pml

...
4076:   proc  1 (Customer:1) barber.pml:42 (state 10)   [((shaved[_pid]==done))]
              1 left done
4078:   proc  1 (Customer:1) barber.pml:46 (state 15)   [printf('%d left %e\\n',_pid,shaved[_pid])]
              1 arrives
4080:   proc  1 (Customer:1) barber.pml:32 (state 1)    [printf('%d arrives\\n',_pid)]
4082:   proc  1 (Customer:1) barber.pml:33 (state 2)    [shaved[_pid] = unattended]
4084:   proc  1 (Customer:1) barber.pml:38 (state 6)    [(((sitting!=0)&&(customers<2)))]
4086:   proc  0 (Barber:1) barber.pml:24 (state 9)      [sitting = 0]
spin: trail ends after 4087 steps
#processes: 5
                queue[0] = 1
                queue[1] = 1
                start = 0
                end = 1
                customers = 1
                sitting = 0
                shaved[0] = 0
                shaved[1] = unattended
                shaved[2] = unattended
                shaved[3] = unattended
                shaved[4] = unattended
4087:   proc  4 (Customer:1) barber.pml:42 (state 10)
4087:   proc  3 (Customer:1) barber.pml:42 (state 10)
4087:   proc  2 (Customer:1) barber.pml:42 (state 10)
4087:   proc  1 (Customer:1) barber.pml:39 (state 7)
4087:   proc  0 (Barber:1) barber.pml:25 (state 10)
5 processes created
````

Ejecutado con pan podemos observar que uno de los clientes está esperando (`customers = 1`) mientras el barbero está durmiendo (`sitting = 0`), de forma que se podria quedar esperando indefinidamente.

Para el apartado 2, haremos uso de la posibilidad de que el barbero este durmiendo _`sleeping`_ y de que un cliente se vaya desatendido, etiqueta _`leftUnattended`_, en este caso tenemos algo similiar al apartado anterior, no se debe de cumplir en ningun instante de tiempo que estas dos secciones se ejecuten al mismo tiempo, entonces :
 - []!(Barber@sleeping && Customer@leftUnattended)

Para verificar esto con Spin, negamos la prueba :
 - ![]!(Barber@sleeping && Customer@leftUnattended)

```` c++
$ spin -t -p barber.pml

010:   proc  0 (Barber:1) barber.pml:17 (state 2)      [printf('%d is being shaved\\n',sitting)]
4012:   proc  0 (Barber:1) barber.pml:18 (state 3)      [shaved[sitting] = done]
4014:   proc  0 (Barber:1) barber.pml:20 (state 4)      [((customers>0))]
4016:   proc  0 (Barber:1) barber.pml:20 (state 5)      [sitting = queue[start]]
4018:   proc  0 (Barber:1) barber.pml:21 (state 6)      [start = ((start+1)%2)]
4020:   proc  0 (Barber:1) barber.pml:22 (state 7)      [customers = (customers-1)]
4022:   proc  0 (Barber:1) barber.pml:16 (state 1)      [((sitting!=0))]
          1 is being shaved
4024:   proc  0 (Barber:1) barber.pml:17 (state 2)      [printf('%d is being shaved\\n',sitting)]
4026:   proc  0 (Barber:1) barber.pml:18 (state 3)      [shaved[sitting] = done]
4028:   proc  0 (Barber:1) barber.pml:24 (state 8)      [((customers==0))]
4030:   proc  0 (Barber:1) barber.pml:24 (state 9)      [sitting = 0]
spin: trail ends after 4031 steps
#processes: 5
                queue[0] = 1
                queue[1] = 1
                start = 1
                end = 1
                customers = 0
                sitting = 0
                shaved[0] = 0
                shaved[1] = done
                shaved[2] = unattended
                shaved[3] = unattended
                shaved[4] = unattended
4031:   proc  4 (Customer:1) barber.pml:42 (state 10)
4031:   proc  3 (Customer:1) barber.pml:42 (state 10)
4031:   proc  2 (Customer:1) barber.pml:42 (state 10)
4031:   proc  1 (Customer:1) barber.pml:44 (state 12)
4031:   proc  0 (Barber:1) barber.pml:25 (state 10)
5 processes created
````

En este caso, podemos ver que se da el caso de que el cliente se marcha sin atender cuando el barbero está durmiendo y el contador de clientes está a 0, pero todas las sillas están ocupadas (????)

Spin detecta ilegalidades en ambas aserciones, dando como resultado que se podrian llegar a cumplir estas. Tambien produciendo los correspondientes contraejemplos.

Con este codigo tambien podemos ver que nos encontramos ante un deadlock, para ello podemos fijarnos el la ejecucion simple de Spin :
``` c++
spin barber0.pml
```
De otra forma si analizamos la traza que spin es capaz de dejarnos :
``` c++
spin -a barber0.pml
gcc -o pan pan.c
./pan
spin -t -p barber0.pml
```
Nos encontramos la razon de porque se produce el timeout
``` c++
 ...
 ...
                  3 arrives
2059:   proc  3 (Customer:1) exercise_a.pml:32 (state 1)        [printf('%d arrives\\n',_pid)]
2060:   proc  3 (Customer:1) exercise_a.pml:33 (state 2)        [shaved[_pid] = unattended]
2061:   proc  3 (Customer:1) exercise_a.pml:40 (state 6)        [(((sitting!=0)&&(customers<1)))]
2062:   proc  3 (Customer:1) exercise_a.pml:41 (state 7)        [queue[end] = _pid]
2063:   proc  3 (Customer:1) exercise_a.pml:42 (state 8)        [end = ((end+1)%1)]
2064:   proc  3 (Customer:1) exercise_a.pml:43 (state 9)        [customers = (customers+1)]
2065:   proc  0 (Barber:1) exercise_a.pml:24 (state 9)  [sitting = 0]
      Barber sleeping
2066:   proc  0 (Barber:1) exercise_a.pml:25 (state 10) [printf('Barber sleeping\\n')]
spin: trail ends after 2066 steps
...
...
``` 
En este caso la ejecucion fue con simplemente 1 sitio en la sala de espera, por simplicidad.
Podemos observar como eventualmente el cliente se mantiene en espera y al mismo tiempo el barbero esta durmiendo, es decir mientras que hay un cliente esperando el barbero esta durmiendo, por lo que no entran mas clientes porque ya esta la sala llena pero al mismo tiempo el barbero no atiende a nadie.

De la misma forma se pueden analizar los apartados del ejercicio A. Como verificamos sin la necesidad de Spin :

 1. El barbero esta `durmiendo` mientras que hay un cliente `esperando`.
 2. El barbero esta `durmiendo` mientras hay clientes que se marchan sin ser `atendidos`. Que son los que no llegan a entrar en la sala de espera ya que esta llena con el cliente al que no atiende el barbero.

# Ejercicio B :
El código se puede encontrar en el archivo de Promela **_barber1.pml_**.

# Ejercicio C :
Prueba nuevamente las propiedades probadas en el Ejercicio A:
 1. El barbero no puede estar durmiendo mientras hay clientes esperando, recordamos :
    - []!(Barber@sleeping && Customer@waiting)
 2. Cualquier cliente nunca debe de irse desatendido mientras el barbero esta durmiendo, recordamos :
    - []!(Barber@sleeping && Customer@leftUnattended)

En el nuevo código marcamos la posicion que corresponderia a las anteriores etiquetas :
``` c++
active proctype Barber() {
    do
    ::          waitI(customers);
                waitB(mutex);
working:        freeseats++;
                sitting=queue[start];
                shaved[sitting]= done;
                start=next(start);
                printf("%d is being shaved\n",sitting);
                signalB(mutex);
                signalB(ready);
sleeping:       sitting = BARBER
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
waiting:            printf("%d Waiting room\n",_pid);
                    signalI(customers);
                    signalB(mutex);
                    waitB(ready);
attended:           shaved[_pid] == done
        :: freeseats == 0 ->
leftUnattended:     printf("%d Skipped, no room", _pid);
                    signalB(mutex);
            skip
        fi
  od
}
```
 De la misma forma que en el anterior ambas propiedades se pueden volver a cumplir debido a como esta estructurado el codigo, pero lo que no va a ocurrir es que debido a estas se produzca un ciclo en el que el barbero este durmiendo y haya clientes esperando indefinidamente.

 ## Nuevas Propiedades :
 1. El barbero puede trabajar indefinidamente.
 2. Si un cliente entra a la sala de espera, este eventualmente sera atendido.
 3. Un cliente puede ser atendido una cantidad infinita de veces. Prueba esto tambien con valores { NumeroClientes < NumeroSillasEspera }. Explica la diferencia.

Para comprobar las propiedades haremos uso de las nuevas etiquetas `working` y `attended`.

Desarrollamos las formulas para comprobar las propiedades :
 1. []<>Barber@working
    - ![]<>`(Barber@working)`
 2. ([]Customer@waiting -> <>Customer@attended)
    - ![](`(Customer@waiting)` -> (<>`(Customer@attended)`))
 3. []<>Customer[1]@attended
    - ![]<>`(Customer[1]@attended)`

Observamos que realizando la comprobacion de la propiedad 1 la evaluacion infinita ofrecida por pan nos indica que esta no se cumple para cualquier instante. Ya que al efectuar la busqueda en cualquier instante de tiempo ya que spin encuentra un error.
``` c++
$ spin -a -f '![]<>(Barber@working)' barber1.pml
$ gcc -o pan pan.c
$ ./pan -m200000
warning: never claim + accept labels requires -a flag to fully verify
warning: for p.o. reduction to be valid the never claim must be stutter-invariant
(never claims generated from LTL formulae are stutter-invariant)
Depth=     383 States=    1e+06 Transitions= 2.82e+06 Memory=   207.529 t=     2.23 R=   4e+05
Depth=   34881 States=    2e+06 Transitions= 5.45e+06 Memory=   276.181 t=      4.5 R=   4e+05
Depth=   86453 States=    3e+06 Transitions= 8.03e+06 Memory=   344.834 t=      6.7 R=   4e+05
Depth=  137961 States=    4e+06 Transitions= 1.06e+07 Memory=   413.486 t=     8.91 R=   4e+05
Depth=  194599 States=    5e+06 Transitions= 1.34e+07 Memory=   482.236 t=     11.5 R=   4e+05
error: max search depth too small
Depth=  199999 States=    6e+06 Transitions= 1.88e+07 Memory=   550.888 t=     15.8 R=   4e+05
Depth=  199999 States=    7e+06 Transitions= 2.45e+07 Memory=   619.541 t=     20.2 R=   3e+05
Depth=  199999 States=    8e+06 Transitions= 2.92e+07 Memory=   688.193 t=     24.2 R=   3e+05
Depth=  199999 States=    9e+06 Transitions= 3.47e+07 Memory=   756.943 t=     28.8 R=   3e+05
^CInterrupted

(Spin Version 6.5.2 -- 6 December 2019)
Warning: Search not completed
        + Partial Order Reduction

Full statespace search for:
        never claim             + (never_0)
        assertion violations    + (if within scope of claim)
        acceptance   cycles     - (not selected)
        invalid end states      - (disabled by never claim)

State-vector 108 byte, depth reached 199999, errors: 0
  9171683 states, stored
 26358870 states, matched
 35530553 transitions (= stored+matched)
        0 atomic steps
hash conflicts:   3906523 (resolved)

Stats on memory usage (in Megabytes):
 1189.565       equivalent memory usage for states (stored*(State-vector + overhead))
  630.169       actual memory usage for states (compression: 52.97%)
                state-vector as stored = 44 byte + 28 byte overhead
  128.000       memory used for hash table (-w24)
   10.681       memory used for DFS stack (-m200000)
  768.662       total actual memory usage



pan: elapsed time 29.6 seconds
pan: rate 309854.16 states/second


$ ./pan -a

warning: for p.o. reduction to be valid the never claim must be stutter-invariant
(never claims generated from LTL formulae are stutter-invariant)
pan:1: acceptance cycle (at depth 76)
pan: wrote barber1.pml.trail

(Spin Version 6.5.2 -- 6 December 2019)
Warning: Search not completed
        + Partial Order Reduction

Full statespace search for:
        never claim             + (never_0)
        assertion violations    + (if within scope of claim)
        acceptance   cycles     + (fairness disabled)
        invalid end states      - (disabled by never claim)

State-vector 108 byte, depth reached 85, errors: 1
       43 states, stored
        0 states, matched
       43 transitions (= stored+matched)
        0 atomic steps
hash conflicts:         0 (resolved)

Stats on memory usage (in Megabytes):
    0.006       equivalent memory usage for states (stored*(State-vector + overhead))
    0.286       actual memory usage for states
  128.000       memory used for hash table (-w24)
    0.534       memory used for DFS stack (-m10000)
  128.730       total actual memory usage



pan: elapsed time 0 seconds
```
En la siguiente traza podemos encontrar el ciclo.
``` c++
$ spin -p -t barber1.pml
...
...
72:    proc  5 (Customer:1) barber1.pml:62 (state 10)  [printf('%d Waiting room\\n',_pid)]
 74:    proc  5 (Customer:1) barber1.pml:25 (state 11)  [customers = (customers+1)]
 76:    proc  5 (Customer:1) barber1.pml:35 (state 13)  [mutex = 1]
  <<<<<START OF CYCLE>>>>>
 78:    proc  4 (Customer:1) barber1.pml:30 (state 1)   [(mutex)]
 78:    proc  4 (Customer:1) barber1.pml:31 (state 2)   [mutex = 0]
 80:    proc  4 (Customer:1) barber1.pml:68 (state 20)  [((freeseats==0))]
                          4 Skipped, no room
 82:    proc  4 (Customer:1) barber1.pml:69 (state 21)  [printf('%d Skipped, no room\\n',_pid)]
 84:    proc  4 (Customer:1) barber1.pml:35 (state 22)  [mutex = 1]
 86:    proc  4 (Customer:1) barber1.pml:71 (state 24)  [(1)]
spin: trail ends after 86 steps
#processes: 9
                queue[0] = 8
                queue[1] = 7
                queue[2] = 6
                queue[3] = 5
                start = 0
                end = 0
                customers = 4
                sitting = 0
                shaved[0] = 0
                shaved[1] = 0
                shaved[2] = 0
                shaved[3] = 0
                shaved[4] = 0
                shaved[5] = unattended
                shaved[6] = unattended
                shaved[7] = unattended
                shaved[8] = unattended
                freeseats = 0
                mutex = 1
                ready = 0
 86:    proc  8 (Customer:1) barber1.pml:66 (state 19)
 86:    proc  7 (Customer:1) barber1.pml:28 (state 18)
 86:    proc  6 (Customer:1) barber1.pml:28 (state 18)
 86:    proc  5 (Customer:1) barber1.pml:28 (state 18)
 86:    proc  4 (Customer:1) barber1.pml:54 (state 27)
 86:    proc  3 (Customer:1) barber1.pml:54 (state 27)
 86:    proc  2 (Customer:1) barber1.pml:54 (state 27)
 86:    proc  1 (Customer:1) barber1.pml:54 (state 27)
 86:    proc  0 (Barber:1) barber1.pml:18 (state 5)
9 processes created
```
Podemos deducir que se produce un interbloqueo ya que el barbero se queda esperando a que cambie el semaforo de la variable de enteros pero como la sala de espera esta llena y no puede entrar ningun cliente, esta no se incrementa.

En el caso de la segunda propiedad, tambien vemos que Spin encuentra tambien un error y su consecuente ciclo :
``` c++
$ spin -a -f '![]((Customer@waiting) -> (<>(Customer@attended)))' barber1.pml
$ gcc -o pan pan.c
$ ./pan -a
warning: for p.o. reduction to be valid the never claim must be stutter-invariant
(never claims generated from LTL formulae are stutter-invariant)
pan:1: acceptance cycle (at depth 3426)
pan: wrote barber1.pml.trail

(Spin Version 6.5.2 -- 6 December 2019)
Warning: Search not completed
        + Partial Order Reduction

Full statespace search for:
        never claim             + (never_0)
        assertion violations    + (if within scope of claim)
        acceptance   cycles     + (fairness disabled)
        invalid end states      - (disabled by never claim)

State-vector 108 byte, depth reached 3475, errors: 1
     2026 states, stored
      829 states, matched
     2855 transitions (= stored+matched)
        0 atomic steps
hash conflicts:         0 (resolved)

Stats on memory usage (in Megabytes):
    0.263       equivalent memory usage for states (stored*(State-vector + overhead))
    0.383       actual memory usage for states
  128.000       memory used for hash table (-w24)
    0.534       memory used for DFS stack (-m10000)
  128.827       total actual memory usage



pan: elapsed time 0.02 seconds
pan: rate    101300 states/second
```
En la traza se ve el ciclo :
``` c++
$ spin -p -t barber1.pml
...
...
3422:   proc  1 (Customer:1) barber1.pml:62 (state 10)  [printf('%d Waiting room\\n',_pid)]
3424:   proc  1 (Customer:1) barber1.pml:25 (state 11)  [customers = (customers+1)]
3426:   proc  1 (Customer:1) barber1.pml:35 (state 13)  [mutex = 1]
  <<<<<START OF CYCLE>>>>>
3428:   proc  5 (Customer:1) barber1.pml:30 (state 1)   [(mutex)]
3428:   proc  5 (Customer:1) barber1.pml:31 (state 2)   [mutex = 0]
3430:   proc  5 (Customer:1) barber1.pml:68 (state 20)  [((freeseats==0))]
                              5 Skipped, no room
3432:   proc  5 (Customer:1) barber1.pml:69 (state 21)  [printf('%d Skipped, no room\\n',_pid)]
3434:   proc  5 (Customer:1) barber1.pml:35 (state 22)  [mutex = 1]
3436:   proc  5 (Customer:1) barber1.pml:71 (state 24)  [(1)]
spin: trail ends after 3436 steps
#processes: 9
                queue[0] = 8
                queue[1] = 7
                queue[2] = 1
                queue[3] = 6
                start = 3
                end = 3
                customers = 4
                sitting = 4
                shaved[0] = 0
                shaved[1] = unattended
                shaved[2] = done
                shaved[3] = done
                shaved[4] = done
                shaved[5] = done
                shaved[6] = unattended
                shaved[7] = unattended
                shaved[8] = unattended
                freeseats = 0
                mutex = 1
                ready = 0
3436:   proc  8 (Customer:1) barber1.pml:66 (state 19)
3436:   proc  7 (Customer:1) barber1.pml:66 (state 19)
3436:   proc  6 (Customer:1) barber1.pml:66 (state 19)
3436:   proc  5 (Customer:1) barber1.pml:54 (state 27)
3436:   proc  4 (Customer:1) barber1.pml:54 (state 27)
3436:   proc  3 (Customer:1) barber1.pml:28 (state 18)
3436:   proc  2 (Customer:1) barber1.pml:28 (state 18)
3436:   proc  1 (Customer:1) barber1.pml:28 (state 18)
3436:   proc  0 (Barber:1) barber1.pml:18 (state 5)
9 processes created
```
Para la tercera propiedad, observamos que tambietampocon se cumple para cualquier instante tal y como nos muestra Spin :
``` c++
$ spin -a -f '![](<>(Customer[1]@attended))' barber1.pml
$ gcc -o pan pan.c
$ ./pan -a
warning: for p.o. reduction to be valid the never claim must be stutter-invariant
(never claims generated from LTL formulae are stutter-invariant)
pan:1: acceptance cycle (at depth 76)
pan: wrote barber1.pml.trail

(Spin Version 6.5.2 -- 6 December 2019)
Warning: Search not completed
        + Partial Order Reduction

Full statespace search for:
        never claim             + (never_0)
        assertion violations    + (if within scope of claim)
        acceptance   cycles     + (fairness disabled)
        invalid end states      - (disabled by never claim)

State-vector 108 byte, depth reached 85, errors: 1
       43 states, stored
        0 states, matched
       43 transitions (= stored+matched)
        0 atomic steps
hash conflicts:         0 (resolved)

Stats on memory usage (in Megabytes):
    0.006       equivalent memory usage for states (stored*(State-vector + overhead))
    0.286       actual memory usage for states
  128.000       memory used for hash table (-w24)
    0.534       memory used for DFS stack (-m10000)
  128.730       total actual memory usage



pan: elapsed time 0.02 seconds
pan: rate      2150 states/second
```
Con su consecuente traza :
```c++
$ spin -p -t barber1.pml
...
...
72:    proc  5 (Customer:1) barber1.pml:62 (state 10)  [printf('%d Waiting room\\n',_pid)]
 74:    proc  5 (Customer:1) barber1.pml:25 (state 11)  [customers = (customers+1)]
 76:    proc  5 (Customer:1) barber1.pml:35 (state 13)  [mutex = 1]
  <<<<<START OF CYCLE>>>>>
 78:    proc  4 (Customer:1) barber1.pml:30 (state 1)   [(mutex)]
 78:    proc  4 (Customer:1) barber1.pml:31 (state 2)   [mutex = 0]
 80:    proc  4 (Customer:1) barber1.pml:68 (state 20)  [((freeseats==0))]
                          4 Skipped, no room
 82:    proc  4 (Customer:1) barber1.pml:69 (state 21)  [printf('%d Skipped, no room\\n',_pid)]
 84:    proc  4 (Customer:1) barber1.pml:35 (state 22)  [mutex = 1]
 86:    proc  4 (Customer:1) barber1.pml:71 (state 24)  [(1)]
spin: trail ends after 86 steps
#processes: 9
                queue[0] = 8
                queue[1] = 7
                queue[2] = 6
                queue[3] = 5
                start = 0
                end = 0
                customers = 4
                sitting = 0
                shaved[0] = 0
                shaved[1] = 0
                shaved[2] = 0
                shaved[3] = 0
                shaved[4] = 0
                shaved[5] = unattended
                shaved[6] = unattended
                shaved[7] = unattended
                shaved[8] = unattended
                freeseats = 0
                mutex = 1
                ready = 0
 86:    proc  8 (Customer:1) barber1.pml:66 (state 19)
 86:    proc  7 (Customer:1) barber1.pml:28 (state 18)
 86:    proc  6 (Customer:1) barber1.pml:28 (state 18)
 86:    proc  5 (Customer:1) barber1.pml:28 (state 18)
 86:    proc  4 (Customer:1) barber1.pml:54 (state 27)
 86:    proc  3 (Customer:1) barber1.pml:54 (state 27)
 86:    proc  2 (Customer:1) barber1.pml:54 (state 27)
 86:    proc  1 (Customer:1) barber1.pml:54 (state 27)
 86:    proc  0 (Barber:1) barber1.pml:18 (state 5)
9 processes created
```

En el caso de que cambiemos a `C`<`N` lo principal que apreciamos es que tarda muchos pasos mas en encontrar el error y ademas el ciclo contiene una cantidad de pasos inmensamente mas grande que a si `N`>`C`. Pasando de 76 a 426 pasos para encontrar el ciclo y de  a 1006 para definir el ciclo:
``` c++
$ ./pan -a
warning: for p.o. reduction to be valid the never claim must be stutter-invariant
(never claims generated from LTL formulae are stutter-invariant)
pan:1: acceptance cycle (at depth 426)
pan: wrote barber1.pml.trail

(Spin Version 6.5.2 -- 6 December 2019)
Warning: Search not completed
        + Partial Order Reduction

Full statespace search for:
        never claim             + (never_0)
        assertion violations    + (if within scope of claim)
        acceptance   cycles     + (fairness disabled)
        invalid end states      - (disabled by never claim)

State-vector 76 byte, depth reached 1433, errors: 1
      717 states, stored
        0 states, matched
      717 transitions (= stored+matched)
        0 atomic steps
hash conflicts:         0 (resolved)

Stats on memory usage (in Megabytes):
    0.071       equivalent memory usage for states (stored*(State-vector + overhead))
    0.286       actual memory usage for states
  128.000       memory used for hash table (-w24)
    0.534       memory used for DFS stack (-m10000)
  128.730       total actual memory usage



pan: elapsed time 0.02 seconds
pan: rate     35850 states/second
```
``` c++
$ ./pan -a
...
...
426:    proc  3 (Customer:1) barber1.pml:60 (state 8)   [queue[end] = _pid]
  <<<<<START OF CYCLE>>>>>
428:    proc  3 (Customer:1) barber1.pml:61 (state 9)   [end = ((end+1)%8)]
                      3 Waiting room
430:    proc  3 (Customer:1) barber1.pml:62 (state 10)  [printf('%d Waiting room\\n',_pid)]
432:    proc  3 (Customer:1) barber1.pml:25 (state 11)  [customers = (customers+1)]
...
...
...
1430:   proc  3 (Customer:1) barber1.pml:58 (state 6)   [freeseats = (freeseats-1)]
1432:   proc  3 (Customer:1) barber1.pml:59 (state 7)   [shaved[_pid] = unattended]
1434:   proc  3 (Customer:1) barber1.pml:60 (state 8)   [queue[end] = _pid]
spin: trail ends after 1434 steps
#processes: 5
                queue[0] = 3
                queue[1] = 2
                queue[2] = 4
                queue[3] = 3
                queue[4] = 4
                queue[5] = 3
                queue[6] = 2
                queue[7] = 4
                start = 1
                end = 3
                customers = 2
                sitting = 3
                shaved[0] = 0
                shaved[1] = done
                shaved[2] = unattended
                shaved[3] = unattended
                shaved[4] = unattended
                freeseats = 5
                mutex = 0
                ready = 0
1434:   proc  4 (Customer:1) barber1.pml:66 (state 19)
1434:   proc  3 (Customer:1) barber1.pml:61 (state 9)
1434:   proc  2 (Customer:1) barber1.pml:66 (state 19)
1434:   proc  1 (Customer:1) barber1.pml:28 (state 18)
1434:   proc  0 (Barber:1) barber1.pml:18 (state 5)
5 processes created
```

## TODO
 - Naive approach:
   - Pasa para cualquier N>=0 sitios en la sala de espera?
 - Classical solution:
   - Exercise C
     - Try query with C<N

## Comandos
Compilar Spin:
``` c++
spin -a -f 'formula' archivo.pml
gcc -o pan pan.c
./pan
```
Argumentos spin
``` c++
 -a // genera el archivo pan.c
 -f // aplica la formula
 -t // muestra la traza de la simulacion generada (.trail), tambien -t[N]
 -p // print all statements
 -t -p // para hacer un seguimiento con todos los datos
```
Para ver si se encuentra un ciclo :
``` c++
spin -t -p file.pml
```
Para encontrar contraejemplos cortos :
``` c++
pan -a -f -i
```