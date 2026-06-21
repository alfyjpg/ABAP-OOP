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

    METHODS showalldata.    "Method 1

    METHODS showconniddata "Method 2
     IMPORTING id TYPE n.

    METHODS numflightsto  "Method 3
    importing code type spfli-airpto
      returning value(number) type i.

Methods getConnid         "Method 4
importing departure type spfli-airpto
          arrival type spfli-airpto
 returning value(id) type spfli-connid.

methods getFlightTime   "Method 5
importing id type n.


methods getAllconnectionFacts   "Method 6
importing id type spfli-connid.


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

"Method 3

method numflightsto.



data itab_satz type spfli.

loop at itab into itab_satz.
  if itab_satz-airpto = code.
  number = number + 1.
  endif.

ENDLOOP.

write : 'Anzahl Flights zum Flughafen:', code, 'sind: ', number,/.

  ENDMETHOD.

"Method 4

method getconnid.

loop at itab into data(itab_satz)
  where AIRPFROM = departure and airpto = arrival.

id = itab_satz-connid.
ENDLOOP.

if sy-subrc = 0.
Write: 'The connection ID between:', departure, 'und', arrival, 'is:', id,/.
else.
  Write: 'The connection ID between:', departure, 'und', arrival, 'exisitert nicht',/.
  endif.

endmethod.

"Method 5
method getFlightTime.

  DATA time type spfli-fltime.
  loop at itab into data(itab_aus) where connid = id.

    time = itab_aus-fltime.
    ENDLOOP.

   Write: 'The Flying time for the connection:', id, 'is: ', time, /.
  ENDMETHOD.


"Method 6
method getAllconnectionFacts.


  loop at itab into data(itab_satz) where connid = id.

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
      else.
        write: id, 'als connectionID exisitiert leider nicht!'.

        ENDIF.
        ENDLOOP.
  ENDMETHOD.
ENDCLASS.


START-OF-SELECTION.

  DATA flight TYPE REF TO flights.

" Objekt erstellen
  CREATE OBJECT flight.
uline.

" Alle Einträge von der Tabelle FlightTable bzw. Spfli auflisten
  flight->showalldata( ).
  uline.

" Verbindungen anzeigen
  flight->showconniddata( 001000 ).
uline.

  "Anzahl Flights zu einem bestimmten Flughafen
flight->numflightsto( 'SFO' ).
uline.

  " Get ConnID
  flight->getConnid( exporting departure = 'JFK'
                                arrival = 'FRA' ).

  "Get flight time
  flight->getflighttime( 0408 ).
  uline.

  flight->getallconnectionfacts( 0408 ).
  uline.
