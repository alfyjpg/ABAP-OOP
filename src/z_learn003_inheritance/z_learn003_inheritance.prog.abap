*&---------------------------------------------------------------------*
*& Report Z_LEARN003_VEHICLE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_LEARN003_Inheritance.


" Class 1 - Viehicle


CLASS Vehicle DEFINITION .

  " Public
  PUBLIC SECTION.

    METHODS: gofaster, "Method 1
      writespeed. "Method 2

  PROTECTED SECTION.
    DATA speed TYPE p DECIMALS 2. " Attribute 1



ENDCLASS.


CLASS Vehicle IMPLEMENTATION .

  METHOD gofaster.

    speed = speed + 1.

  ENDMETHOD.


  METHOD writespeed.

    WRITE: 'The Vehicle speed is: ', me->speed, /.
  ENDMETHOD.

ENDCLASS.


" Class 2 - Car

CLASS car DEFINITION INHERITING FROM vehicle.

  " Public Section
  PUBLIC SECTION.

    METHODS: refuel. "Method 1

    "protected section
  PROTECTED SECTION.

    DATA fuellevel TYPE i.  " Attribute 1





ENDCLASS.

CLASS car IMPLEMENTATION.

  METHOD refuel.
    fuellevel = 60.

    WRITE 'You have just filled up your fuel Tank'.

  ENDMETHOD.


ENDCLASS.


" Class 3

CLASS boat DEFINITION INHERITING FROM vehicle.

ENDCLASS.

CLASS boat IMPLEMENTATION.

ENDCLASS.


START-OF-SELECTION.

  DATA: car  TYPE REF TO car,
        boat TYPE REF TO boat.

  CREATE OBJECT: car,
                 boat.



  car->gofaster( ).
  car->writespeed( ).
  car->refuel( ).

  uline.


boat->gofaster( ).
boat->writespeed( ).
