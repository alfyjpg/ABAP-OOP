*&---------------------------------------------------------------------*
*& Report Z_LEARN003_CAR
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_learn003_car.


* Exporting / Returning ---> when the variable is an attribute of the class. Therefor the method will be familiar with it
* Changing ---> When the varaible is defined outside the class scope. Like the Main programm


*As long as we are in the class universum, we are viewing importing, exporting, changing and returning from the view
*  of the Method.
*But as long as we are outside from the class, we look at these 4 Statments (importing, exporting, changing and returning)
*  from the prespective of the user.

CLASS car DEFINITION.

  PUBLIC SECTION.

"constrcutors also come in the public section.

  METHODS constructor
    IMPORTING
      make           TYPE c
      model         TYPE c
      numberofseats TYPE i
      maxspeed      TYPE i.


    DATA: make          TYPE c,
          model         TYPE c,
          numberofseats TYPE i,
          speed         TYPE i,
          maxspeed      TYPE i.

    CLASS-DATA numberofcars TYPE i.   "static attribute

    METHODS setnumseats
      IMPORTING numseat TYPE i.

    METHODS gofaster
      IMPORTING increment TYPE i
      EXPORTING result    TYPE i.

    METHODS goslower
      IMPORTING decrement     TYPE i
      RETURNING VALUE(result) TYPE i.

    methods viewCar.



ENDCLASS.

CLASS car IMPLEMENTATION.

  " Das nutzen von me-> ist genau ähnlich mit dem Nutzen von this. in Java.

  METHOD constructor.
    me->make = make.
    me->model = model.
    me->numberofseats = numberofseats.
    me->maxspeed = maxspeed.

    numberofcars = numberofcars + 1. "Initial value of variables from type i is 0
  ENDMETHOD.

  METHOD setnumseats.
    numberofseats = numseat.
  ENDMETHOD.

* It is ture, that speed are visible for the methods, but we still need to update the value of the attribute speed
* in order to the attribute itself to have an updated value.


  METHOD gofaster.
    IF speed + increment >= maxspeed.
      speed = maxspeed.
    ELSE.
      speed = increment + speed.
    ENDIF.

    result = speed.

  ENDMETHOD.


  METHOD goslower.

    speed = speed - decrement.

    IF speed <= 0.
      speed = 0.
    ENDIF.

    result = speed.
  ENDMETHOD.


  METHOD viewCar.

    write : 'Make : ', 15 make,/.
    write : 'Model:', 15 model,/.
    write : 'Number of Seats: ', 15 numberofseats,/.
    write : 'Max Speed: ', 15 maxspeed,/.
    write : 'Serialnumber: ', 15 numberofcars,/.

    ENDMETHOD.

ENDCLASS.


"Erstellen von Objeckt ohne Constructor

*DATA car1 TYPE REF TO car.
*create object car1.


start-of-selection.

"Erstellen ein Objekt mit Constructor

DATA car1 TYPE REF TO car.

"Remember, we are outside the class. So we look to the 4 Statment from the prespective of the user.
" Here the user is exporting variables to constructor.

CREATE OBJECT car1
  EXPORTING
    make        = 'BMW'
    model         = '200C'
    numberofseats = 5
    maxspeed      = 250.

uline.
