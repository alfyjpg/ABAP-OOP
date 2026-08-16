*&---------------------------------------------------------------------*
*& Report Z_LEARN003_EVENTS
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_learn003_events.


CLASS chef DEFINITION.

  PUBLIC SECTION.

    EVENTS: food_cooked.
    METHODS: call_waiter.

ENDCLASS.

CLASS chef IMPLEMENTATION.

  METHOD call_waiter.
    WRITE:/ 'Chef is hitting the bell to call waiter because of the Event: food_cooked'.
    RAISE EVENT food_cooked.
    WRITE:/ 'Chef is done calling the waiter. Event: food_cooked is done!'.
    uline.

  ENDMETHOD.

ENDCLASS.







CLASS customer DEFINITION.

  PUBLIC SECTION.
    METHODS: constructor IMPORTING VALUE(TableNumber) TYPE i,
      call_waiter.

    "Because when we ask for help, the waiter has to know which table is seeking Help!
    EVENTS: need_help EXPORTING VALUE(tableNumber) TYPE i.

  PROTECTED SECTION.

    DATA TableNumber TYPE i.

ENDCLASS.

CLASS customer IMPLEMENTATION.

  METHOD constructor.
    me->tablenumber = TableNumber.
  ENDMETHOD.


  METHOD call_waiter.
    WRITE:/ 'Customer is raising their hand to call the waiter because of the Event: need_help'.
    RAISE EVENT need_help EXPORTING TableNumber = me->tablenumber.
    WRITE:/ 'Customer is done riaisng their hand to call the waiter... Need_help event is done!'.
    uline.
  ENDMETHOD.
ENDCLASS.


START-OF-SELECTION.

  DATA: chef       TYPE REF TO chef,
        customer01 TYPE REF TO customer,
        customer02 TYPE REF TO customer.


  create Object chef.
  create Object customer01 exporting
    TableNumber = 5.
  create Object customer02 exporting
    TableNumber = 10.


  chef->call_waiter( ).
  customer01->call_waiter( ).
  customer02->call_waiter( ).
