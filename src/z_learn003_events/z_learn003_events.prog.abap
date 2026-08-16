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

  " This Method revoke the Event!
  METHOD call_waiter.
    WRITE:/ 'Chef is hitting the bell to call waiter because of the Event: food_cooked'.
    RAISE EVENT food_cooked.
    WRITE:/ 'Chef is done calling the waiter. Event: food_cooked is done!'.
    ULINE.

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

  " This method revokes the Event
  METHOD call_waiter.
    WRITE:/ 'Customer is raising their hand to call the waiter because of the Event: need_help'.
    RAISE EVENT need_help EXPORTING TableNumber = me->tablenumber.
    WRITE:/ 'Customer is done riaisng their hand to call the waiter... Need_help event is done!'.
    ULINE.
  ENDMETHOD.
ENDCLASS.


CLASS waiter DEFINITION.

  PUBLIC SECTION.

    METHODS: constructor IMPORTING WaiterName TYPE String,
      GoingForTheChef FOR EVENT food_cooked OF chef,
      GoingForTheCustomer FOR EVENT need_help OF customer IMPORTING TableNumber.

  PROTECTED SECTION.
    DATA name TYPE string.

ENDCLASS.


CLASS waiter IMPLEMENTATION.


  METHOD constructor.
    me->name = WaiterName.
  ENDMETHOD.

  METHOD GoingForTheChef.
    WRITE:/ name, 'is running to get the food from the Chef!'.
    ULINE.
  ENDMETHOD.

  METHOD GoingForTheCustomer.
    WRITE: name, 'Is running towards Table:', TableNumber, 'to serve the Customer!'.
    ULINE.
  ENDMETHOD.

ENDCLASS.

START-OF-SELECTION.

  DATA: chef       TYPE REF TO chef,
        customer01 TYPE REF TO customer,
        customer02 TYPE REF TO customer.

DATA: waiter type ref to waiter.

  CREATE OBJECT chef.

  CREATE OBJECT customer01
    EXPORTING
      TableNumber = 5.

  CREATE OBJECT customer02
    EXPORTING
      TableNumber = 10.

create object waiter  "We can't use the Event-Hanlder here or calling them by ourselfves, because"
  exporting WaiterName = 'Bob'. "That is the Job of the Registerd-Event, that listens to the events and
                          "Revoke the Hanlder-Method when it is time.... Doing That manuelly is Wrong.




  chef->call_waiter( ).
  customer01->call_waiter( ).
  customer02->call_waiter( ).
