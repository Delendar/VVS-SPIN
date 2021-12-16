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

Para el apartado 2, haremos uso de la posibilidad de que el barbero este durmiendo _`sleeping`_ y de que un cliente se vaya desatendido, etiqueta _`leftUnattended`_, en este caso tenemos algo similiar al apartado anterior, no se debe de cumplir en ningun instante de tiempo que estas dos secciones se ejecuten al mismo tiempo, entonces :
 - []!(Barber@sleeping && Customer@leftUnattended)

Para verificar esto con Spin, negamos la prueba :
 - ![]!(Barber@sleeping && Customer@leftUnattended)

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
## TODO
 - Naive approach:
   - Mostrar contraejemplos?
   - Pasa para cualquier N>=0 sitios en la sala de espera?
 - Classical solution:
   - Exercise B
   - Exercise C

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