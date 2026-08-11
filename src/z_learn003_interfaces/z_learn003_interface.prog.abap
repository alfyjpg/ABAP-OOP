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

ALIASES geschwindigkeit for speed~writespeed. " Using Aliases.

   methods: goFaster.

  protected section.


  DATA: speed type i .
  endclass.


  class train IMPLEMENTATION.


    method goFaster.

      speed = speed + 5.
      endmethod.

    method speed~writespeed. " This should still the same. We don't use Aliases here.

      write:/ 'Aktuelle Geschwindigkeit des Zuges ist: ', speed.
      endmethod.

    endclass.


    start-of-selection.


    DATA: train type ref to train.

    create object train.

    train->goFaster( ).

 "   train->speed~writespeed( ).
 train->geschwindigkeit( ).
