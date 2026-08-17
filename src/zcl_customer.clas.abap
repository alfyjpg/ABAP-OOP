class ZCL_CUSTOMER definition
  public
  create public .

public section.

  events NEED_HELP
    exporting
      value(TABLENUMBER) type I .

  methods CONSTRUCTOR
    importing
      value(TABLENUMBER) type I .
  methods CALL_WAITER .
protected section.

  data TABLENUMBER type I .
private section.
ENDCLASS.



CLASS ZCL_CUSTOMER IMPLEMENTATION.


  method CALL_WAITER.

    WRITE:/ 'Customer is raising their hand to call the waiter because of the Event: need_help'.
    RAISE EVENT need_help EXPORTING TableNumber = me->tablenumber.
    WRITE:/ 'Customer is done riaisng their hand to call the waiter... Need_help event is done!'.
    ULINE.

  endmethod.


  method CONSTRUCTOR.

    me->tablenumber = TableNumber.

  endmethod.
ENDCLASS.
