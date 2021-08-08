#include "timers.h"


// Actualiza el timer
void FSM_RefreshTimer( Timer *timer ){

    switch( timer->state ){
        case TIMER_WAITING:
            break;

        case TIMER_WORKING:;

            int16_t delta;
            // delta es el tiempo (en ms = ticks) que pasó de la última actualización
            delta = HAL_GetTick() - timer->__last_systick;
            if( delta > 0 ){

                // Si el delta es mayor (o igual) a lo que quedaba, el timer terminó
                if( delta >= timer->time_left ){
                    timer->time_left = 0;
                    timer->state = TIMER_FINISHED;
                } 

                // Sino, sólamente resto el tiempo
                else timer->time_left -= delta;
            }

            // Actualizo el último systick leído
            timer->__last_systick += delta;
            break;

        case TIMER_FINISHED:
            
            // Si pasó al menos 1 SysTick, paso a WAITING
            timer->state = ( HAL_GetTick() - timer->__last_systick > 0 ) ? TIMER_WAITING : TIMER_FINISHED;
            break;

        default:
            // Por default, sólo cambio el estado
            timer->state = TIMER_WAITING;
            break;
    } 

}
// Actualiza todos los timers
void FSM_RefreshAllTimers( Timer *timers, uint8_t cant ){

    if( timers != NULL ){
        
        for(uint8_t i = 0; i < cant; i ++){

            FSM_RefreshTimer( timers + i * sizeof(Timer) );

        }

    } 

}

// Configura y dispara el timer
void startTimer( Timer *timer, uint32_t time_ms ){
    
    // Seteo el tiempo
    timer->init_time = time_ms;
    timer->time_left = time_ms;

    // Actualizo el último systick
    timer->__last_systick = HAL_GetTick();

    // Disparo el timer
    timer->state = TIMER_WORKING;

}
// Configura sin disparar
void configTimer( Timer *timer, uint32_t time_ms ){
    
    // Seteo el tiempo
    timer->init_time = time_ms;
    timer->time_left = time_ms;
    
    // Lo dejo esperando
    timer->state = TIMER_WAITING;

}
// Dispara el timer con su configuración previa
void fireTimer( Timer *timer ){
    
    // Seteo el tiempo configurado previamente
    timer->time_left = timer->init_time;
    
    // Actualizo el último systick
	timer->__last_systick = HAL_GetTick();

    // Disparo el timer
    timer->state = TIMER_WORKING;

}


// Chequeos del estado del timer
uint8_t timerIsWaiting( Timer *timer ){
    return (timer->state == TIMER_WAITING) ? 1 : 0;
}
uint8_t timerIsWorking( Timer *timer ){
    return (timer->state == TIMER_WORKING) ? 1 : 0;
}
uint8_t timerJustFinished( Timer *timer ){
    return (timer->state == TIMER_FINISHED) ? 1 : 0;
}

// Pausar el timer
void pauseTimer( Timer *timer ){

    // Pauso el timer
    timer->state = TIMER_WAITING;

}
// Continuar el timer
void playTimer( Timer *timer ){

	// Actualizo el último systick
	timer->__last_systick = HAL_GetTick();

	// Dejo que siga donde quedó
    timer->state = TIMER_WORKING;

}
// Apagar el timer
void stopTimer( Timer *timer ){

    // Lo dejo sin tiempo restante
    timer->time_left = 0;

    // Lo dejo esperando
    timer->state = TIMER_WAITING;

}
