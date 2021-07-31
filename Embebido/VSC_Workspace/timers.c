#include "timers.h"


// Actualiza el timer
void FSM_RefreshTimer( Timer *timer ){

    switch( timer->state ){
        case WAITING:
            break;

        case WORKING:;

            int16_t delta;
            // delta es el tiempo (en ms = ticks) que pasó de la última actualización
            delta = HAL_GetTick() - timer->__last_systick;
            if( delta > 0 ){

                // Si el delta es mayor (o igual) a lo que quedaba, el timer terminó
                if( delta >= timer->time_left ){
                    timer->time_left = 0;
                    timer->state = FINISHED;
                } 

                // Sino, sólamente resto el tiempo
                else timer->time_left -= delta;
            }

            // Actualizo el último systick leído
            timer->__last_systick += delta;
            break;

        case FINISHED:
            
            // Si pasó al menos 1 SysTick, paso a WAITING
            timer->state = ( HAL_GetTick() - timer->__last_systick > 0 ) ? WAITING : FINISHED;
            break;

        default:
            timer->state = WAITING;
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

    else {
        return;
    }

}

// Configura y dispara el timer
void startTimer( Timer *timer, uint32_t time_ms ){
    
    // Seteo el tiempo
    timer->init_time = time_ms;
    timer->time_left = time_ms;

    // Disparo el timer
    timer->state = WORKING;

}
// Configura sin disparar
void configTimer( Timer *timer, uint32_t time_ms ){
    
    // Seteo el tiempo
    timer->init_time = time_ms;
    timer->time_left = time_ms;
    
    // Lo dejo esperando
    timer->state = WAITING;

}
// Dispara el timer con su configuración previa
void fireTimer( Timer *timer ){
    
    // Seteo el tiempo configurado previamente
    timer->time_left = timer->init_time;
    
    // Disparo el timer
    timer->state = WORKING;

}


// Chequeos del estado del timer
uint8_t timerIsWaiting( Timer *timer ){
    return (timer->state == WAITING) ? 1 : 0;
}
uint8_t timerIsWorking( Timer *timer ){
    return (timer->state == WORKING) ? 1 : 0;
}
uint8_t timerJustFinished( Timer *timer ){
    return (timer->state == FINISHED) ? 1 : 0;
}

// Pausar el timer
void pauseTimer( Timer *timer ){

    // Pauso el timer
    timer->state = WAITING;

}
// Continuar el timer
void playTimer( Timer *timer ){

    // Dejo que siga donde quedó
    timer->state = WORKING;

}
// Apagar el timer
void stopTimer( Timer *timer ){

    // Lo dejo sin tiempo restante
    timer->time_left = 0;

    // Lo dejo esperando
    timer->state = WAITING;

}
