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

    METHODS: refuel, "Method 1
             writespeed REDEFINITION.

    "protected section
  PROTECTED SECTION.

    DATA fuellevel TYPE i.  " Attribute 1





ENDCLASS.

CLASS car IMPLEMENTATION.

  METHOD refuel.
    fuellevel = 60.

    WRITE 'You have just filled up your fuel Tank'.

  ENDMETHOD.


method writespeed.

  " Overriding a method from teh superclass vehicel
  write : 'The Car speed is: ', me->speed, / .

  endmethod.

ENDCLASS.


" Class 3

CLASS boat DEFINITION INHERITING FROM vehicle.

  public SECTION.
  methods writespeed redefinition.

ENDCLASS.

CLASS boat IMPLEMENTATION.


method writespeed.

  " Overriding a method from teh superclass vehicel
  write : 'The BOAT speed is: ', me->speed, /.

            call method super->writespeed.  " Calling a method from the super class.
  endmethod.


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
