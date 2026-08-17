*&---------------------------------------------------------------------*
*& Report Z_LEARN003_GLOBAL_EVENT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_LEARN003_GLOBAL_EVENT.

  DATA: chef       TYPE REF TO ZCL_chef,
        customer01 TYPE REF TO ZCL_customer,
        customer02 TYPE REF TO ZCL_customer.

DATA: waiter type ref to ZCL_waiter.

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

set HANDLER waiter->goingforthechef for chef.
set handler waiter->goingforthecustomer for all INSTANCES.


  chef->call_waiter( ).
  customer01->call_waiter( ).
  customer02->call_waiter( ).
