#ifndef _DEBOUNCER_H_
#define _DEBOUNCER_H_

	#include "types.h"
    #include "pinConnections.h"


    /* TIEMPOS --- LEER

    TIME_TO_CAPTURE_MS: es el tiempo (en milisegundos) entre cada lectura de las entradas EN CRUDO
            ----> el define de TIME_BETWEEN_READS_MS está en muxReader.h

    */
    #define SAMPLES_TO_VALIDATE     30
    #define INIT_STATE              ( (uint64_t) 0)
    #define TIME_TO_CAPTURE_MS      1

   
    typedef struct Debouncer_TimerInterruptionFlag{
        uint8_t timer_finished;
    } Debouncer_TimerInterruptionFlag;
    
    typedef enum DebouncerStates{
        WAITING_NEXT_SYSTICK,
        READING,
        DEBOUNCING
    } DebouncerStates;
    
    typedef struct debouncer{
        DebouncerStates state;
        TIM_HandleTypeDef *htim;

        sample last_reading;
        sample changes_in_readings[ SAMPLES_TO_VALIDATE ];
        sample debounced_sample;
        uint16_t i;

        uint32_t __last_systick;
    } debouncer;


    // Inicializar el flag del timer
    void initDebouncer_TimerInterruptionFlag( Debouncer_TimerInterruptionFlag *flags );
    // Inicializar el lector
    void initDebouncer( debouncer *debouncer, TIM_HandleTypeDef *htim );

    // FSM del lector
    void FSM_Debouncer( debouncer *debouncer, Debouncer_TimerInterruptionFlag *flags );

    // Obtener las lecturas limpias
    sample getDebouncedSamples( debouncer *debouncer );

    
    // Escribir A y B
    void _writeAB( uint8_t a, uint8_t b );
    // Leer de las entradas en crudo
    void _readRawInputs( debouncer *debouncer, Debouncer_TimerInterruptionFlag *flags );
    // Hacer el antirrebote
    void _debounce( debouncer *debouncer );


    /*  Uso ejemplo:

    main(){

        ...

        sample new_sample;
        debouncer antirrebote;
        
        ...

        initDebouncer( &antirrebote );

        ...

        while(1){

            ...

            FSM_Debouncer( &antirrebote );

            ...

            new_sample = getDebouncedSamples( &antirrebote );
            
            ...
        }
    }
    
    */

#endif /* _DEBOUNCER_H_ */
