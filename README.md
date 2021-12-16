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
 - []!(Barber@sleepingBarber && Customer@customerWaits)

Para verificar esto con Spin hemos de negar el predicado :
 - ![]!(Barber@sleepingBarber && Customer@customerWaits)

Para el apartado 2, haremos uso de la posibilidad de que el barbero este durmiendo _`sleeping`_ y de que un cliente se vaya desatendido, etiqueta _`leftUnattended`_, en este caso tenemos algo similiar al apartado anterior, no se debe de cumplir en ningun instante de tiempo que estas dos secciones se ejecuten al mismo tiempo, entonces :
 - []!(Barber@sleeping && Customer@leftUnattended)

Para verificar esto con Spin, negamos la prueba :
 - ![]!(Barber@sleeping && Customer@leftUnattended)

Spin detecta ilegalidades en ambas aserciones, dando como resultado que se podrian llegar a cumplir estas. Tambien produciendo los correspondientes contraejemplos.

## TODO
 - Naive approach:
   - Razones del deadlock
   - Razones del erroneo funcionamiento. (Un poco mas en detalle el porque se ejecutan al mismo tiempo?)