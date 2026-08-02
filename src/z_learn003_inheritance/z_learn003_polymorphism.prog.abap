*&---------------------------------------------------------------------*
*& Report Z_LEARN003_POLYMORPHISM
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_learn003_polymorphism.

CLASS account DEFINITION ABSTRACT.


  PUBLIC SECTION.

    METHODS: constructor IMPORTING
                           VALUE(i_accountHolder) TYPE string
                           VALUE(i_amount)        TYPE f,

      withdraw ABSTRACT
        IMPORTING i_money               TYPE f
                  i_money_notice_period TYPE String
        EXPORTING e_money               TYPE f,

      deposit ABSTRACT
        IMPORTING i_money TYPE f
        EXPORTING e_money TYPE f,

      get_accountHolder
        RETURNING VALUE(r_accountHolder) TYPE string.


  PROTECTED SECTION.
    DATA: accountHolder TYPE string,
          balance       TYPE f.

ENDCLASS.


CLASS account IMPLEMENTATION.

  METHOD constructor.

    accountHolder = i_accountHolder.
    balance = i_amount.

  ENDMETHOD.

  METHOD get_accountHolder.
    r_accountHolder = accountholder.
  ENDMETHOD.
ENDCLASS.

CLASS current DEFINITION INHERITING FROM account.

  PUBLIC SECTION.

    METHODS: withdraw REDEFINITION,
             deposit REDEFINITION.
ENDCLASS.

CLASS current IMPLEMENTATION.

  METHOD withdraw.

    WRITE:/ 'Opening Balance:', balance.

    IF i_money < balance.

      balance = balance - i_money.
      e_money = i_money.

    ELSE.
      WRITE:/ 'You do not have fundes for a withdrawl in your account!'.
    ENDIF.

    WRITE:/ 'Closing Balance', balance.

  ENDMETHOD.

  METHOD deposit.

    WRITE:/ 'Opening Balance', balance.
    balance = balance + i_money.
    e_money = i_money.
    WRITE:/ 'Your Balance after Depoisitng is:' ,balance.
  ENDMETHOD.
ENDCLASS.


CLASS notice30 DEFINITION INHERITING FROM account.
public section.

  METHODS: withdraw REDEFINITION,
    deposit REDEFINITION.

  PROTECTED SECTION.
    DATA: within_notice_period TYPE c.
ENDCLASS.

CLASS notice30 IMPLEMENTATION.

  METHOD withdraw.

    DATA: zBalance TYPE f.

    IF within_notice_period = 'Y'.
      zBalance = balance * '0.95'.
    ELSE.
      ZBalance = balance.
    ENDIF.

    WRITE: 'Opening Balance is:', balance.

    IF i_money < zBalance.
      balance = zBalance - ( i_money + ( balance * '0.05' ) ).
      e_money = i_money.
      IF within_notice_period = 'Y'.
        WRITE: 'Penalty is applied!'.
      ENDIF.
    ELSE.
      WRITE: 'You do not have such a sufficent amount of money for that withdrawl'.
    ENDIF.

    WRITE: 'Closing Balance:', balance.
  ENDMETHOD.


  METHOD deposit.

 write: 'Opening Balance:', balance.

 balance = balance + ( i_money * '1.001' ).
 e_money = i_money * '1.001'.

 write: 'Cosing Balance is:', balance.
  ENDMETHOD.
ENDCLASS.

start-of-selection.

DATA: o_account type ref to account,
      account_tab type table of ref to account, "Important
      holder type string,
      amount type f.


create object o_account type current
        EXPORTING i_accountHolder = 'MR A'
                  i_amount = 1000.

APPEND o_account to account_tab.


create object o_account type notice30
        exporting i_accountHolder = 'MR B'
                  i_amount = 1000.

append o_account to account_tab.

 CREATE OBJECT o_account
    TYPE
      current
    EXPORTING
      i_accountHolder = 'Mr C'
      i_amount         = 1000.
  APPEND o_account TO account_tab.

  CREATE OBJECT o_account
    TYPE
      notice30
    EXPORTING
      i_accountHolder = 'Mr D'
      i_amount         = 2500.
  APPEND o_account TO account_tab.

  LOOP AT account_tab INTO o_account.
    holder = o_account->get_accountHolder( ).
    o_account->deposit(  EXPORTING i_money = 225 IMPORTING e_money = amount ).
    WRITE: / 'Deposit transaction for', holder, 'to the sum of ', amount EXPONENT 0 DECIMALS 2 LEFT-JUSTIFIED.
    SKIP.

    o_account->withdraw(  EXPORTING i_money = 225
                                    i_money_notice_period = 'N'
                          IMPORTING e_money = amount ).
    WRITE: / 'Withdrawal transaction for', holder, 'to the sum of ', amount EXPONENT 0 DECIMALS 2 LEFT-JUSTIFIED.
    SKIP.

    holder = o_account->get_accountHolder( ).
    o_account->deposit(  EXPORTING i_money = 225 IMPORTING e_money = amount ).
    WRITE: / 'Deposit transaction for', holder, 'to the sum of ', amount EXPONENT 0 DECIMALS 2 LEFT-JUSTIFIED.
    SKIP.

    o_account->withdraw(  EXPORTING i_money = 225
                                    i_money_notice_period = 'Y'
                          IMPORTING e_money = amount ).
    WRITE: / 'Withdrawal transaction for', holder, 'to the sum of ', amount EXPONENT 0 DECIMALS 2 LEFT-JUSTIFIED.
    ULINE.

  ENDLOOP.
