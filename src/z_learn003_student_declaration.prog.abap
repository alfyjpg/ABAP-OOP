*&---------------------------------------------------------------------*
*& Report Z_LEARN003_STUDENT_DECLARATION
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_learn003_student_declaration.

CLASS student DEFINITION.

"public section

public section.
DATA: name type c length 40,
      age type i,
      gender type c length 1 read-only.

class-data counter type i.

"private section

DATA: id type c length 15,
      password type c length 20.


ENDCLASS.
