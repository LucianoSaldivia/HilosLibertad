#ifndef _MUX_READER_H_
#define _MUX_READER_H_

    #include "types.h"
    #include "pinConnections.h"
    #include "timers.h"
    #include "debouncer.h"



    /* TIEMPOS --- LEER

	#define DEBUG_MODE --> en types.h

    TIME_BETWEEN_FRAMES_MS >= 30 * TIMEOUT_TIME
            ----> el define de TIMEOUT_TIME está en dataSender.h

    */

 	#if defined(DEBUG_MODE)
		#define TIME_BETWEEN_FRAMES		((uint16_t) (5 * SEG))
	#else
		#define TIME_BETWEEN_FRAMES		((uint16_t) (1 * MIN + 5 * MILISEG))
	#endif


    typedef enum MuxReaderStates{
        WAITING_FOR_TIMER,
        READY_TO_BE_READ
    } MuxReaderStates;
    
    typedef struct MuxReader{
        MuxReaderStates state;
        sample newest_sample;
        debouncer debouncer;

        Timer timer;
    } MuxReader;


    // Inicializar el lector
    void initMuxReader( MuxReader *reader, TIM_HandleTypeDef *htim );

    // FSM del lector
    void FSM_MuxReader( MuxReader *reader, Debouncer_TimerInterruptionFlag *TIM_flag );

    // Chequear el estado
    uint8_t newSampleReady( MuxReader *reader );
    // Obtener las lecturas
    sample getSample( MuxReader *reader );


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
            if( newSampleReady( &reader ) ){
                new_sample = getSample( &reader );
            }
            
            ...
        }
    }
    
    */

#endif /* _MUX_READER_H_ */
