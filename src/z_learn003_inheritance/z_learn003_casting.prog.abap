*&---------------------------------------------------------------------*
*& Report Z_LEARN003_CASTING
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_learn003_casting.


CLASS vehicel DEFINITION.

  PUBLIC SECTION.
    METHODs gofaster.

  PROTECTED SECTION.
    DATA speed TYPE i.


ENDCLASS.


CLASS vehicel IMPLEMENTATION.

method gofaster.
  speed =  speed + 1.

  write: 'The Vehicle speed is:', speed,/ .

  endmethod.

ENDCLASS.



CLASS car DEFINITION INHERITING FROM vehicel.

public section.

Methods: gofaster REDEFINITION,
          writeSpeed.

ENDCLASS.


class car IMPLEMENTATION.

  method gofaster.

    speed = speed + 10.
    write: 'The car speed is', speed,/.
    endmethod.


    method writespeed.

      write: 'My Car is Grease Lightning.',/.
      endmethod.

  endclass.


start-of-selection.


DATA: vehicel type ref to vehicel,
      car type ref to car.

create object: vehicel,
               car.

"Normale Aufruf von Methoden ohne Widening oder narrowing casting.
vehicel->gofaster( ).
car->gofaster( ).
car->writespeed( ).



" Nun Narrow Casting

DATA: vehicel1 type ref to vehicel,
      car1 type ref to car.

create object: vehicel1,
               car1.

vehicel1 = car1.

" Die Variable sieht ab jetzt alle Methode, Variable und Attribute, die sowohl in der
" Superklasse deklariert sind als auch die MEthode, Variable und Attribute in der
" subclass deklariert, aber schon wurzel in der Superklasse haben. Wie z.B. overrides Methods

vehicel1->gofaster( ).

* vehicel1->gofaster( ).   " Error
* vehicel1->writespeed( ). " Error



*Jetzt wieder widening*


IF vehicel1 is instance of car.

  car1 ?= vehicel1.

  else.
    write: 'Kein Car - Kein Casting möglich!'.
  endif.


  car1->gofaster( ).
  car1->writespeed( ).
