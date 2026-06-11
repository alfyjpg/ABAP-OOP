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

    CLASS-METHODS class_constructor.     "Static constrcutor
    CLASS-DATA numberofcars TYPE i.      "static attribute 1
    CLASS-DATA carlog TYPE c LENGTH 100. "static attribute 2

    METHODS constructor   " Normal constrcutor | constructors also come in the public section.
      IMPORTING
        make          TYPE c
        model         TYPE c
        numberofseats TYPE i
        maxspeed      TYPE i.


    DATA: make          TYPE c LENGTH 10,  " Declaration of Attributes
          model         TYPE c,
          numberofseats TYPE i,
          speed         TYPE i,
          maxspeed      TYPE i.


    " Methods Declaration

    METHODS setnumseats
      IMPORTING numseat TYPE i.

    METHODS gofaster
      IMPORTING increment TYPE i
      EXPORTING result    TYPE i.

    METHODS goslower
      IMPORTING decrement     TYPE i
      RETURNING VALUE(result) TYPE i.

    METHODS viewcar. "Method ohne Importing/Exporting



ENDCLASS.

CLASS car IMPLEMENTATION.

  METHOD class_constructor. "Static constructor.
    carlog = 'The object from the class car has been successfully initiated'.
    WRITE : carlog,/.
  ENDMETHOD.

  METHOD constructor.     "Normal constrcutor
    me->make = make.
    me->model = model.
    me->numberofseats = numberofseats.
    me->maxspeed = maxspeed.

    numberofcars = numberofcars +   1. "Static attribute. Initial value of variables from type i is 0

    " Das nutzen von me-> ist genau ähnlich mit dem Nutzen von this. in Java.
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


  METHOD viewcar.

    WRITE : 'Make : ', 15 make.
    WRITE : /'Model:', 15 model.
    WRITE : /'Number of Seats: ', 15 numberofseats.
    WRITE : /'Max Speed: ', 15 maxspeed.
    WRITE : /'Serialnumber: ', 15 numberofcars.
    WRITE :/ 'Speed: ', speed.

  ENDMETHOD.

ENDCLASS.

START-OF-SELECTION.

* Erstellen von Objeckt ohne Constructor
*
*DATA car1 TYPE REF TO car.
*create object car1.


  "Erstellen ein Objekt mit Constructor
  DATA :car1      TYPE REF TO car,
        theresult TYPE i.

  "Remember, we are outside the class. So we look to the 4 Statment from the prespective of the user.
  "Here the user is exporting variables to constructor.
  CREATE OBJECT car1
    EXPORTING
      make          = 'BMW'
      model         = '200C'
      numberofseats = 5
      maxspeed      = 250.


  car1->viewcar( ). "Calling a normal Method.
  ULINE.

  car1->setnumseats( 10 ). "Calling a method with 1 pararmeter.

  car1->viewcar( ).
  ULINE.

  car1->setnumseats( numseat = 5 ). "Calling a method with 1 parameter but another alternative way of writting
  "Where parameter = data.
  car1->viewcar( ).
  ULINE.


  car1->gofaster( EXPORTING increment = 50  IMPORTING result = theresult ). "Calling a method with import and export statment.

  car1->viewcar( ).
  WRITE:/ 'We added', theresult, 'KM/H'.
  ULINE.


  car1->goslower( EXPORTING decrement = 10  RECEIVING result = theresult ). "Calling a method with import and retrurning statment.
  car1->viewcar( ).                                                           "Notice that returning turns into recieving when we call it
  WRITE:/ 'new speed is: ', theresult, 'KM/H'.
  ULINE.


write: 'Q: How many number of cars have we produced so far?'.
write: 'A: Well, we have so far produced', car=>numberofcars, 'so far. '.


"Another way of using returning / functional method

theresult = car1->goslower( exporting decrement = 5 ).

 car1->viewcar( ).
  WRITE:/ 'new speed is (using functional method): ', theresult, 'KM/H'.
  ULINE.
