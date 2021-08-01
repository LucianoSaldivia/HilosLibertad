#ifndef _TIMERS_H_
#define	_TIMERS_H_

	#include "types.h"
    
    typedef enum {
        TIMER_WAITING,
        TIMER_WORKING,
        TIMER_FINISHED
    } timerState;

    // Estructura con todos los flags usados
    typedef struct {
        
        uint32_t __last_systick;
        uint32_t init_time;
        uint32_t time_left;
        timerState state;
        /* 
        state = 
            WAITING     ->  Esperando a ser disparado
            WORKING     ->  Funcionando
            FINISHED    ->  Terminado (éste estado SÓLO DURA UN SysTick!)
                                a menos que se llame a stopTimer() para forzar 
                                el estado WAITING
        
        Empieza en WAITING si sólo se lo configura, cuando se lo dispara, pasa a estado 
        WORKING. Una vez llega a 0, queda en estaod FINISHED por 1 sólo SysTick, luego 
        pasa nuevamente a WAITING, dado que espera ser disparado nuevamente.
        */
        
    } Timer;

    
    // Actualiza el timer
    void FSM_RefreshTimer( Timer *timer );
    // Actualiza todos los timers
    void FSM_RefreshAllTimers( Timer *timer, uint8_t cant );

    // Configurar y disparar el timer
    void startTimer( Timer *timer, uint32_t time_ms );
    // Configurar sin disparar
    void configTimer( Timer *timer, uint32_t time_ms );
    // Disparar el timer con su configuración previa
    void fireTimer( Timer *timer );
    
    // Chequeos del estado del timer
    uint8_t timerIsWaiting( Timer *timer );
    uint8_t timerIsWorking( Timer *timer );
    uint8_t timerJustFinished( Timer *timer );

    // Pausar el timer
    void pauseTimer( Timer *timer );
    // Continuar el timer
    void playTimer( Timer *timer );
    // Apagar el timer
    void stopTimer( Timer *timer );

#endif
