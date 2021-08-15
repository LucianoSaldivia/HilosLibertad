#include <stdio.h>
#include "muxReader.h"


// Inicializo el lector
void initMuxReader( MuxReader *r, TIM_HandleTypeDef *htim ){
    // Seteo el estado inicial
    r->state = WAITING_FOR_TIMER;
    // Inicializo el debouncer
    initDebouncer( &(r->debouncer), htim );
    // Inicializo el sample
    r->newest_sample = getDebouncedSample( &(r->debouncer) );
    // Apago el timer
    stopTimer( &(r->timer) );
}

// FSM del lector
void FSM_MuxReader( MuxReader *r, Debouncer_TimerInterruptionFlag *TIM_flag ){

    // Refresco el timer
    FSM_RefreshTimer( &(r->timer) );

    // Refresco el debouncer
    FSM_Debouncer( &(r->debouncer), TIM_flag );

    switch( r->state ){
        case WAITING_FOR_TIMER:
            // Si el timer está trabajando, me voy (casi siempre)
            if( timerIsWorking( &(r->timer) ) ){
                break;
            }
        	// Si justo terminó (una vez por lectura)
            else if( timerJustFinished( &(r->timer) ) ){
        		// Apago el timer
        		stopTimer( &(r->timer) );
        		// Tomo la nueva lectura debounceada
                r->newest_sample = getDebouncedSample( &(r->debouncer) );
                // Aviso que está lista para ser leída
        		r->state = READY_TO_BE_READ;
        	}
            // Si está esperando (primera vez)
        	else if( timerIsWaiting( &(r->timer) ) ){
        		// Disparo el timer para la siguiente lectura
        		startTimer( &(r->timer), TIME_BETWEEN_FRAMES );
        	}
            break;

        case READY_TO_BE_READ:
            // Disparo el timer
            startTimer( &(r->timer), TIME_BETWEEN_FRAMES );
            // Vuelvo a esperar el timer
            r->state = WAITING_FOR_TIMER;
            break;

        default:
            // Por default, espero al timer
        	r->state = WAITING_FOR_TIMER;
            break;
    }
}

// Chequeo de estado
uint8_t newSampleReady( MuxReader *r ){
    return (r->state == READY_TO_BE_READ) ? 1 : 0;
}
// Chequeo de lecturas
sample getSample( MuxReader *r ){
    return r->newest_sample;
}
