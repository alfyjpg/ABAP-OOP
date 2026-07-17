*&---------------------------------------------------------------------*
*& Report Z_LEARN003_INHERIT_CONSTRUCTOR
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_learn003_inherit_constructor.


CLASS ford DEFINITION.

  PUBLIC SECTION.
    CLASS-METHODS class_constructor.  "Static constructor


    METHODS constructor
      IMPORTING p_model TYPE string.

  PROTECTED SECTION.
    DATA: model TYPE string.
    CLASS-DATA carlog TYPE string.
ENDCLASS.

CLASS ford IMPLEMENTATION.

  METHOD class_constructor.
    carlog = 'FORD object has been inistantiated'.
    WRITE :/ carlog.
  ENDMETHOD.

  METHOD constructor.
    me->model = p_model.
  ENDMETHOD.
ENDCLASS.


CLASS mercedez DEFINITION INHERITING FROM ford.

  PUBLIC SECTION.
    CLASS-METHODS class_constructor.


ENDCLASS.

CLASS mercedez IMPLEMENTATION.

  METHOD class_constructor.
    carlog = 'Mercedez object has been inistantiated'.
    WRITE :/ carlog.

  ENDMETHOD.

ENDCLASS.

CLASS audi DEFINITION INHERITING FROM mercedez.
  PUBLIC SECTION.

class-methods class_constructor.



    METHODS constructor
      IMPORTING p_model TYPE string
                wheels  TYPE i.

  PROTECTED   SECTION.
    DATA wheels TYPE i. " Wir haben hier nur wheels definiert, weil P_model ist schon
    "in der Superklasse definiert nämlich in der public section.
ENDCLASS.               "Das heißt die Variable wird vererbt.


CLASS audi IMPLEMENTATION.

  METHOD class_constructor.
    carlog = 'AUDI object has been inistantiated'.
    WRITE :/ carlog.

  ENDMETHOD.


  METHOD constructor.
    CALL METHOD super->constructor "Genau als ob wie eine noramlle methode aufrufen im
      EXPORTING                     " Hauptprogramm.
        p_model = p_model.
    "P_model von der    "P_model von der
    "local constructor  "Superklasse COnstructor.
    me->wheels = wheels.

  ENDMETHOD.
ENDCLASS.



START-OF-SELECTION.


  DATA: ford     TYPE REF TO ford,
        mercedez TYPE REF TO mercedez,
        audi     TYPE REF TO audi.

  CREATE OBJECT: ford EXPORTING  p_model = 'FOCUS',
                 mercedez EXPORTING p_model = 'C-CLASS',
                 audi EXPORTING p_model = 'A4' wheels = 4.
