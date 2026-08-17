class ZCL_CHEF definition
  public
  create public .

public section.

  events FOOD_COOKED .

  methods CALL_WAITER .
protected section.
private section.
ENDCLASS.



CLASS ZCL_CHEF IMPLEMENTATION.


  method CALL_WAITER.

    WRITE:/ 'Chef is hitting the bell to call waiter because of the Event: food_cooked'.
    RAISE EVENT food_cooked.
    WRITE:/ 'Chef is done calling the waiter. Event: food_cooked is done!'.
    ULINE.


  endmethod.
ENDCLASS.
