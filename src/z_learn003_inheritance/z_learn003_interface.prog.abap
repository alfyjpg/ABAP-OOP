*&---------------------------------------------------------------------*
*& Report Z_LEARN003_INTERFACE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_learn003_interface.

INTERFACE speed.

methods writespeed.
ENDINTERFACE.


class train DEFINITION.

  public section.
  Interfaces: speed.

   methods: goFaster.

  protected section.


  DATA: speed type i .
  endclass.


  class train IMPLEMENTATION.


    method goFaster.

      speed = speed + 5.
      endmethod.

    method speed~writespeed.

      write:/ 'Aktuelle Geschwindigkeit des Zuges ist: ', speed.
      endmethod.

    endclass.


    start-of-selection.


    DATA: train type ref to train.

    create object train.

    train->goFaster( ).

    train->speed~writespeed( ).
