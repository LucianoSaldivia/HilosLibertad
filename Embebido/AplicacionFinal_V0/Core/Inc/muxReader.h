#ifndef _MUX_READER_H_
#define _MUX_READER_H_

    #include "types.h"
    #include "pinConnections.h"
    #include "timers.h"



    /* TIEMPOS --- LEER

    TIME_DESIRED_BETWEEN_READS >= 30 * TIMEOUT_TIME
    * -> el define de TIMEOUT_TIME está en dataSender.h

    */
	#define TIME_DESIRED_BETWEEN_READS		((uint16_t) (12 * SEG))	/* (1 * MIN) */
    #define TIME_BETWEEN_WRITE_AND_READ     ((uint16_t) (10 * MILISEG))

	#define TIME_BETWEEN_READS              ((uint16_t) (TIME_DESIRED_BETWEEN_READS - 4*TIME_BETWEEN_WRITE_AND_READ))


    // estados del lector
    typedef enum MuxReaderStates{
        READER_START,
        READER_READY,
        READER_WORKING_00,
        READER_WORKING_01,
        READER_WORKING_10,
        READER_WORKING_11
    } MuxReaderStates;
    
    // struct MuxReader
    typedef struct MuxReader{
        MuxReaderStates state;
        sample readings;

        Timer timer;
    } MuxReader;

    // Inicializar el lector
    void initMuxReader( MuxReader *reader );

    // FSM del lector
    void FSM_MuxReader( MuxReader *reader );
    // Escribir A y B
    void _writeAB( uint8_t a, uint8_t b );
    // Leer todas las entradas
    void _read16Inputs( sample *readings, MuxReaderStates state );

    // Chequear el estado
    uint8_t muxReaderIsReady( MuxReader *reader );
    // Obtener las lecturas
    sample getReadings( MuxReader *reader );


    /*  Uso ejemplo:

    main(){

        ...

        MuxReader reader;
        
        ...

        initMuxReader( &reader );

        ...

        while(1){

            ...

            FSM_MuxReader( &reader );

            ...

            // Sólo obtengo las lecturas si está ready
            if( muxReaderIsReady( &reader ) ){
                new_sample = getReadings( &reader );
            }
            
            ...
        }
    }
    
    */

#endif /* _MUX_READER_H_ */
