*&---------------------------------------------------------------------*
*& Report Z_LEARN003_INHERIT_STATIC
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_LEARN003_INHERIT_STATIC.

" Hier testet man das Konzept von Static bei´Vererbung.

class person DEFINITION.

  public section.
  CLass-DATA: numberofpersons type i value 5.
  Endclass.

  class student DEFINITION inheriting from person.

    endclass.

    start-of-selection.

    write : 'Person class', person=>numberofpersons,/.
    write : 'Student class', student=>numberofpersons,/.

    student=>numberofpersons = 20.
    write 'After Changing!'.

    write : 'Person class', person=>numberofpersons,/.
    write : 'Student class', student=>numberofpersons,/.
