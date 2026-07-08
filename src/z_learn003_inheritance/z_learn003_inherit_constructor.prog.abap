*&---------------------------------------------------------------------*
*& Report Z_LEARN003_INHERIT_CONSTRUCTOR
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_learn003_inherit_constructor.


CLASS ford DEFINITION.

  PUBLIC SECTION.

    METHODS constructor
      IMPORTING p_model TYPE string.

  PROTECTED SECTION.
    DATA: model TYPE string.

ENDCLASS.

CLASS ford IMPLEMENTATION.

  METHOD constructor.
    me->model = p_model.
  ENDMETHOD.
ENDCLASS.


CLASS mercedez DEFINITION INHERITING FROM ford.

ENDCLASS.


CLASS audi DEFINITION INHERITING FROM mercedez.
  PUBLIC SECTION.

    METHODS constructor
      IMPORTING p_model TYPE string
                wheels  TYPE i.

  PROTECTED   SECTION.
    DATA wheels TYPE i. " Wir haben hier nur wheels definiert, weil P_model ist schon
                        "in der Superklasse definiert nämlich in der public section.
ENDCLASS.               "Das heißt die Variable wird vererbt.


CLASS audi IMPLEMENTATION.

  METHOD constructor.
    CALL METHOD super->constructor "Genau als ob wie eine noramlle methode aufrufen im
      EXPORTING                     " Hauptprogramm.
          p_model = p_model.
"P_model von der    "P_model von der
"local constructor  "Superklasse COnstructor.
  ENDMETHOD.
ENDCLASS.



start-OF-SELECTION.


DATA: ford type ref to ford,
      mercedez type ref to mercedez,
      audi type ref to audi.

create object: ford exporting  p_model = 'FOCUS',
               mercedez exporting p_model = 'C-CLASS',
               audi exporting p_model = 'A4' wheels = 4.
