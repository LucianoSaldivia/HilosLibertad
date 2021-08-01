#ifndef _MUX_READER_H_
#define _MUX_READER_H_

    #include "types.h"
    #include "pinConnections.h"
    #include "timers.h"

    #define MILISEG                         1
    #define SEG                             1000*MILISEG
    #define MIN                             60*SEG

    #define TIME_BETWEEM_READS              1*MIN
    #define TIME_BETWEEN_WRITE_AND_READ     5*MILISEG

    // estados del lector
    typedef enum MuxReaderStates{
        READER_READY,
        READER_WORKING_00,
        READER_WORKING_01,
        READER_WORKING_10,
        READER_WORKING_11
    } MuxReaderStates;
    
    // struct MuxReader
    typedef struct{
        sample readings;
        MuxReaderStates state;
        Timer timer;
    } MuxReader;

    // Inicializo el lector
    void initMuxReader( MuxReader *reader );

    // FSM del lector
    void FSM_MuxReader( MuxReader *reader );
    // Escribo A y B
    void _writeAB( uint8_t a, uint8_t b );
    // Leo todas las entradas
    void _read16Inputs( sample *readings, MuxReaderStates state );

    // Chequeo de estado
    uint8_t muxReaderIsReady( MuxReader *reader );
    // Chequeo de lecturas
    sample getReadings( MuxReader *reader );


    /*  Uso ejemplo:

    initMuxReader( &reader );
    ...
    while(1){
        ...
        FSM_MuxReader( &reader );
        ...
        if( muxReaderIsReady( &reader ) ){
            new_sample = getReadings( &reader );
        }
        ...
    
    */

#endif