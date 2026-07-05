*&---------------------------------------------------------------------*
*& Report Z_LEARN003_CAR2
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_learn003_car2.

CLASS vehicle DEFINITION FINAL.

  PUBLIC SECTION.
    METHODS drive.

ENDCLASS.

CLASS vehicle IMPLEMENTATION.

  METHOD drive.
    WRITE: / 'Vehicle is driving!'.
  ENDMETHOD.

ENDCLASS.

" Nicht möglich. Das Schlüsselwort Final ermöglich keine Vererbungsmöglichkeit
*CLASS car DEFINITION INHERITING FROM vehicle.
*ENDCLASS.


***-------------------------- Neue Klasse ***----------------------

CLASS vehicle2 DEFINITION.
  PUBLIC SECTION.
    METHODS drive FINAL.    " Diese Methode darf keiner überschreiben
    METHODS refuel.         " Diese darf überschrieben werden
ENDCLASS.

CLASS vehicle2 IMPLEMENTATION.
  METHOD drive.
    WRITE: / 'Vehicle is driving - this cannot be changed!'.
  ENDMETHOD.

  METHOD refuel.
    WRITE: / 'Vehicle is refueling!'.
  ENDMETHOD.
ENDCLASS.

" Subklasse versucht drive zu überschreiben:
CLASS car2 DEFINITION INHERITING FROM vehicle2.
  PUBLIC SECTION.
    "  METHODS drive REDEFINITION.    " Fehlgeschlagen, weil die Methode drive ist FINAL!
    METHODS refuel REDEFINITION.
ENDCLASS.

CLASS car2 IMPLEMENTATION.
  METHOD refuel.
    WRITE: / 'Car is refueling with petrol!'.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.

  DATA: car2     TYPE REF TO car2,
        vehicle2 TYPE REF TO vehicle2.

  CREATE OBJECT: car2,
  vehicle2.


" Erstmal vehicle2

vehicle2->drive( ).
vehicle2->refuel( ).

uline.

car2->drive( ).
car2->refuel( ).
