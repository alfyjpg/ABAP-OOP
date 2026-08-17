class ZCL_WAITER definition
  public
  create public .

public section.

  methods CONSTRUCTOR
    importing
      !WAITERNAME type STRING .
  methods GOINGFORTHECHEF
    for event FOOD_COOKED of ZCL_CHEF .
  methods GOINGFORTHECUSTOMER
    for event NEED_HELP of ZCL_CUSTOMER
    importing
      !TABLENUMBER .
protected section.

  data NAME type STRING .
private section.
ENDCLASS.



CLASS ZCL_WAITER IMPLEMENTATION.


  method CONSTRUCTOR.

    me->name = WaiterName.

  endmethod.


  method GOINGFORTHECHEF.

    WRITE:/ name, 'is running to get the food from the Chef!'.
    ULINE.

  endmethod.


  method GOINGFORTHECUSTOMER.

    WRITE:/ name, 'Is running towards Table:', TableNumber, 'to serve the Customer!'.
    ULINE.

  endmethod.
ENDCLASS.
