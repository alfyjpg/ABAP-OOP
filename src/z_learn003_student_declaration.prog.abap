*&---------------------------------------------------------------------*
*& Report Z_LEARN003_STUDENT_DECLARATION
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_learn003_student_declaration.

CLASS student DEFINITION.

  "public section

  PUBLIC SECTION.
    DATA: name   TYPE c LENGTH 40,
          age    TYPE i,
          gender TYPE c value 'U'.

"Static Attribute
    CLASS-DATA counter TYPE i.


    " Methods

    "Method 1
    METHODS setname
      IMPORTING namein TYPE c.

    "Method 2
    METHODS getname
      EXPORTING nameout TYPE c.

    " Method 3
methods setfemale
changing geschlecht type c.

 " Method 4
methods setmale
changing geschlecht type c.

 " functional Method - Method 5

 methods genderstatus
 importing geschlecht type c
RETURNING VALUE(gendertext) TYPE string.

*Niemals type c alleine. Entweder c mit länge oder einfach String


    "private section

    DATA: id       TYPE c LENGTH 15,
          password TYPE c LENGTH 20.


ENDCLASS.


CLASS student IMPLEMENTATION.

*We already had name as an improting parameter, so that means
*and since we want to set the name of the variable name, then
*we will need to make the variable name get the value of the imported object

  METHOD setname.
    name = namein.
  ENDMETHOD.


* This method should export the variable called nameout.
* Since we already know that nameout are the variable that is going to be
* exported anyway after the method is finish, then we can use that exported varaible
  " and make it carry the value of the name we want to give out

  METHOD getname.
    nameout = name.
  ENDMETHOD.

*1. In changing, the object already comes with a value to the method

method setfemale.
  geschlecht = 'F'.
  ENDMETHOD.

  method setmale.
  geschlecht = 'F'.
  ENDMETHOD.

 method genderstatus .
  if geschlecht = 'M'.
    gendertext = 'Male'.
    elseif geschlecht  = 'F'.
      gendertext = 'Female'.
      else.
        gendertext = 'Unknown'.
        endif.
  endmethod.

ENDCLASS.


* In order to solve the confusiton that happends between importing, exporting and changing
* i want you to iamgine this:

* Will the method accept Parameters in?  ----> importing (Normally the varaible here has no value, brand new )
* Will the method gives varaibles out? ---> exporting

* Will there be varaible (that has a vlaue)  go  IN the method and then
* it's value will change and wil be exported again OUT of the method  ---> changing

* Always think of yourself as the method. What kind of parameters are going in/out, their types, will they have a value or n't!

*When you define a method parameter, it is just a placeholder name that only exists inside the method!
*The real variable is connected to the placeholder only when you call the method from outside!
*

*Parameter names and attribute names are independent from each other —
*they only get connected when you call the method!

* Returning works only with call by value and it only gives back 1 Parameter, 1 Object, 1 Variable
