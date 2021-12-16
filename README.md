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
Using the naive approach code, force `Spin` to obtain counterexamples of the following (safety) properties:
 1. The barber cannot be sleeping while there are customers waiting.
 2. Any customer (take, for instance, 1) should never leave unattended while the barber is sleeping.
```
 Para el apartado 1 necesitamos comprobar que tanto el proceso del barbero como los clientes no se encuentran en cierto punto en el mismo instante, los puntos los indicamos de la siguiente forma :
``` c++
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
```
De esta forma dejamos indicado el punto en donde se debe de encontrar el proceso del barbero _`barberSleeping`_.
``` c++
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
                   end=next(end);       // mutex lock
            customers++;     
		    shaved[_pid]==done   // wait until being shaved
      :: sitting!=BARBER && customers==N ->
                   skip
      fi;
  leave:    printf("%d left %e\n",_pid,shaved[_pid])
  od
}
```
Y dejamos indicado el punto en donde se debe de encontrar el proceso del cliente _`customerWaits`_.

Para esto se debe de cumplir que estén activas las dos condiciones, _`sleepingBarber`_ y _`customerWaits`_, entonces :
 - [](Barber@sleepingBarber && Customer@customerWaits)
Para verificar esto con Spin:
 - ![](Barber@sleepingBarber && Customer@customerWaits)