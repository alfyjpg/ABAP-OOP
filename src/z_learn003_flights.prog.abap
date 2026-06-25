*&---------------------------------------------------------------------*
*& Report Z_LEARN003_INTERNAL_TABLES
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_learn003_flights.

CLASS flights DEFINITION.

  PUBLIC SECTION.

    METHODS constructor.  "Method constructor
    TYPES fligttable TYPE STANDARD TABLE OF spfli. " Structure of the internal table

    METHODS showalldata.    "Method 1

    METHODS showconniddata "Method 2
      IMPORTING id TYPE n.

    METHODS numflightsto  "Method 3
      IMPORTING code          TYPE spfli-airpto
      RETURNING VALUE(number) TYPE i.

    METHODS getConnid         "Method 4
      IMPORTING departure TYPE spfli-airpto
                arrival   TYPE spfli-airpto
      RETURNING VALUE(id) TYPE spfli-connid.

    METHODS getFlightTime   "Method 5
      IMPORTING id          TYPE n
      RETURNING VALUE(time) TYPE spfli-fltime.


    METHODS getAllconnectionFacts   "Method 6
      IMPORTING id           TYPE spfli-connid
      RETURNING VALUE(table) TYPE spfli.

methods printoutwa
importing itab_satz type spfli.

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
  METHOD  showconniddata.

    DATA itab_satz TYPE spfli.
    SELECT SINGLE * FROM spfli INTO itab_satz WHERE connid = id.

    IF sy-subrc = 0.
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

    ELSE.
      WRITE 'Dieser Flügnummer/Flügid ist existiert leider nicht. '.
    ENDIF.

  ENDMETHOD.

  "Method 3

  METHOD numflightsto.


* The concept of using transporting no fields is new to me
* This makes sure to find a specific row of data without really copying that content of that row
* into a variable. We can just Say that it only use to count or to make sure a specific data/content/row or key exist.
* Transporting no fields can work with (Loop At and READ TABLE. )
    DATA itab_satz TYPE spfli.

    LOOP AT itab TRANSPORTING NO FIELDS WHERE airpto = code.
      number = number + 1.


    ENDLOOP.

 "   WRITE : 'Anzahl Flights zum Flughafen:', code, 'sind: ', number,/.

  ENDMETHOD.

  "Method 4

  METHOD getconnid.

* We could have used the loop at but for efficency purposes
* It is better to use directly read table.

* Notice also that while using read table, we didn't have to use AND in order to connect
* between the two conditions WITH KEY. Which is in contray to what happens when we use when condition.



    READ TABLE itab INTO DATA(itab_aus) WITH KEY AIRPto = arrival
                                                  airpfrom = departure.

    id = itab_aus-connid.
*    IF sy-subrc = 0.
*      WRITE: 'The connection ID between:', departure, 'und', arrival, 'is:', id,/.
*    ELSE.
*      WRITE: 'The connection ID between:', departure, 'und', arrival, 'exisitert nicht',/.
*    ENDIF.

*  LOOP AT itab INTO DATA(itab_satz)
*    WHERE airpfrom = departure AND airpto = arrival.
*
*    id = itab_satz-connid.
*  ENDLOOP.
*
*  IF sy-subrc = 0.
*    WRITE: 'The connection ID between:', departure, 'und', arrival, 'is:', id,/.
*  ELSE.
*    WRITE: 'The connection ID between:', departure, 'und', arrival, 'exisitert nicht',/.
*  ENDIF.

  ENDMETHOD.

  "Method 5
  METHOD getFlightTime.



    READ TABLE itab INTO DATA(itab_aus) WITH KEY connid = id.

    time = itab_aus-fltime.


 "   WRITE: 'The Flying time for the connection:', id, 'is: ', time, /.

*    DATA time TYPE spfli-fltime.
*    LOOP AT itab INTO DATA(itab_aus) WHERE connid = id.
*
*      time = itab_aus-fltime.
*    ENDLOOP.
*
*    WRITE: 'The Flying time for the connection:', id, 'is: ', time, /.
  ENDMETHOD.


  "Method 6
  METHOD getAllconnectionFacts.


    read table itab INTO table with key connid = id.

      IF sy-subrc <> 0.
        WRITE: id, 'als connectionID exisitiert leider nicht!'.

      ENDIF.



*
*    LOOP AT itab INTO DATA(itab_satz) WHERE connid = id.
*
*      IF sy-subrc = 0.
*        WRITE : 'CARRID:', itab_satz-carrid, 'CONID:', itab_satz-connid, 'COUNTRYFR:', itab_satz-countryfr.
*        WRITE : 'CITYFROM:', itab_satz-cityfrom.
*        WRITE : 'AIRPFROM:', itab_satz-airpfrom.
*        WRITE : 'COUNTRYTO:', itab_satz-countryto.
*        WRITE : 'CITYTO:', itab_satz-cityto.
*        WRITE : 'AIRPTO:', itab_satz-airpto.
*        WRITE : 'FLTIME:', itab_satz-fltime.
*        WRITE : 'DEPTIME:', itab_satz-deptime.
*        WRITE : 'ARRTIME', itab_satz-arrtime.
*        WRITE : 'DISTANCE:', itab_satz-distance.
*        WRITE : 'DISID:', itab_satz-distid.
*        WRITE : 'FLTYPE:', itab_satz-fltype.
*        WRITE : 'PERIOD:', itab_satz-period,/.
*      ELSE.
*        WRITE: id, 'als connectionID exisitiert leider nicht!'.
*
*      ENDIF.
*    ENDLOOP.
  ENDMETHOD.


  method printoutwa.
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
    endmethod.
ENDCLASS.


START-OF-SELECTION.

  DATA: flight TYPE REF TO flights,
        numberflights type i,
        connid type spfli-connid,
        time type spfli-fltime,
       wa type spfli.

  " Objekt erstellen
  CREATE OBJECT flight.
  ULINE.

  " Alle Einträge von der Tabelle FlightTable bzw. Spfli auflisten
  flight->showalldata( ).
  ULINE.

  " Verbindungen anzeigen
  flight->showconniddata( 001000 ).
  ULINE.

  "Anzahl Flights zu einem bestimmten Flughafen
 numberflights =  flight->numflightsto( 'SFO' ).
  WRITE : 'Anzahl Flights zum Flughafen: sind: ', numberflights,/.
  ULINE.

  " Get ConnID
connid =  flight->getConnid( EXPORTING departure = 'JFK'
                                arrival = 'FRA' ).

  uline.

  "Get flight time
 time =  flight->getflighttime( 0408 ).
  WRITE: 'The Flying time for the connection is: ', time, /.
  ULINE.

  wa = flight->getallconnectionfacts( 0408 ).
  flight->printoutwa( wa ).

  ULINE.
