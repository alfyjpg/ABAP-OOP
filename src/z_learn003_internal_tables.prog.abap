*&---------------------------------------------------------------------*
*& Report Z_LEARN003_INTERNAL_TABLES
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_learn003_internal_tables.

CLASS flights DEFINITION.

  PUBLIC SECTION.

    METHODS constructor.  "Method constructor
    TYPES fligttable TYPE STANDARD TABLE OF spfli. " Structure of the internal table

    METHODS showalldata. "Method 1

    METHODS showconniddata "Method 2
     IMPORTING id TYPE n.

  PRIVATE SECTION.

    DATA itab TYPE fligttable. "The internal table itself


ENDCLASS.

CLASS flights IMPLEMENTATION.

  METHOD constructor.

    SELECT * FROM spfli INTO TABLE itab.
    IF sy-subrc = 0.
      WRITE: 'Die Tabelle ist erfolgreich mit Daten aufgefüllt.',/.
    ELSE.
      WRITE: 'Etwas schief ist gelaufen'.
    ENDIF.



  ENDMETHOD.

"Method 1
  METHOD showalldata.

    DATA itab_satz TYPE spfli.
    LOOP AT itab INTO itab_satz.

      WRITE : 'CARRID:', itab_satz-carrid, 'CONID:', itab_satz-connid, 'COUNTRYFR:', itab_satz-countryfr.
      WRITE : 'CITYFROM:', itab_satz-cityfrom.
      WRITE : 'AIRPFROM:', itab_satz-airpfrom.
      WRITE : 'COUNTRYTO:', itab_satz-countryto.
      WRITE : 'CITYTO:', itab_satz-cityto.
      WRITE : 'AIRPTO:', itab_satz-airpto.
      WRITE : 'FLTIME:', itab_satz-fltime.
      WRITE : 'DEPTIME:', itab_satz-deptime.
      WRITE : 'ARRTIME', itab_satz-arrtime.
      WRITE : 'DISTANCE:', itab_satz-distance.
      WRITE : 'DISID:', itab_satz-distid.
      WRITE : 'FLTYPE:', itab_satz-fltype.
      WRITE : 'PERIOD:', itab_satz-period,/.

    ENDLOOP.

  ENDMETHOD.

"Method 2
method  showconniddata.

   data itab_satz type spfli.
  select single * from spfli into itab_satz where connid = id.

    if sy-subrc = 0.
   WRITE : 'CARRID:', itab_satz-carrid, 'CONID:', itab_satz-connid, 'COUNTRYFR:', itab_satz-countryfr.
      WRITE : 'CITYFROM:', itab_satz-cityfrom.
      WRITE : 'AIRPFROM:', itab_satz-airpfrom.
      WRITE : 'COUNTRYTO:', itab_satz-countryto.
      WRITE : 'CITYTO:', itab_satz-cityto.
      WRITE : 'AIRPTO:', itab_satz-airpto.
      WRITE : 'FLTIME:', itab_satz-fltime.
      WRITE : 'DEPTIME:', itab_satz-deptime.
      WRITE : 'ARRTIME', itab_satz-arrtime.
      WRITE : 'DISTANCE:', itab_satz-distance.
      WRITE : 'DISID:', itab_satz-distid.
      WRITE : 'FLTYPE:', itab_satz-fltype.
      WRITE : 'PERIOD:', itab_satz-period,/.

      Else.
        write 'Dieser Flügnummer/Flügid ist existiert leider nicht. '.
        ENDIF.

  ENDMETHOD.
ENDCLASS.


START-OF-SELECTION.

  DATA flight TYPE REF TO flights.

  CREATE OBJECT flight.

  flight->showalldata( ).
  uline.

  flight->showconniddata( 001000 ).
