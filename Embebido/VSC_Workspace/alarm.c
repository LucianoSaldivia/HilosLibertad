#include "alarm.h"

// Inicializo la Alarma
void initAlarm( Alarm *alarm ){
    
    // Sin tipo
    alarm->type = NONE;

    // Estado IDLE
    alarm->state = IDLE;

    // Inicializo el timer
    configTimer( &(alarm->timer), DEFAULT_BEEP_TIME );

}

// FSM de la Alarma
void FSM_Alarm( Alarm *alarm ){
    
    switch( alarm->type ){

        // Si no hay tipo de alarma
        case NONE:
            // Me aseguro de dejar apagado el beeper
            __turnOffBeeper();
            break;

        // Para la de tipo Beep Único
        case SINGLE_BEEP:
            // Según el estado
            switch( alarm->state ){
                
                // Si no empezó
                case IDLE:
                    // Disparo el timer para un beep
                    startTimer( &(alarm->timer), SINGLE_BEEP_TIME );
                    // Enciendo el Beeper
                    __turnOnBeeper();
                    // Cambio de estado
                    alarm->state = FIRST_BEEP;
                    break;

                case FIRST_BEEP:
                	// Refresco el Timer
                	FSM_RefreshTimer( &(alarm->timer) );
                    // Si el timer está funcionando
                    if( timerIsWorking( &(alarm->timer) ) )
                        break;
                    // Si el timer terminó
                    else if( timerJustFinished( &(alarm->timer) ) ){
                        // Disparo el timer para el resto del ciclo
                        startTimer( &(alarm->timer), TL_FOR_SINGLE_BEEP );
                        // Apago el Beeper
                        __turnOffBeeper();
                        // Cambio de estado
                        alarm->state = COMPLETING_CYCLE;
                    }
                    break;

                case COMPLETING_CYCLE:
                	// Refresco el Timer
					FSM_RefreshTimer( &(alarm->timer) );
                    // Si el timer está funcionando
                    if( timerIsWorking( &(alarm->timer) ) )
                        break;
                    // Si el timer terminó
                    else if( timerJustFinished( &(alarm->timer) ) ){
                        // Disparo el timer para el primer beep (repito el ciclo)
                        startTimer( &(alarm->timer), SINGLE_BEEP_TIME );
                        // Enciendo el Beeper
                        __turnOnBeeper();
                        // Cambio de estado
                        alarm->state = FIRST_BEEP;
                    }
                    break;

                default:
                    // Si no tiene estado, le asigno IDLE
                    alarm->state = IDLE;
                    break;

            }
            break;

        // Para el tipo Doble Beep
        case DOUBLE_BEEP:
            // Según el estado
            switch( alarm->state ){
                
                // Si no empezó
                case IDLE:
                    // Disparo el timer para un beep
                    startTimer( &(alarm->timer), DOUBLE_BEEP_TIME );
                    // Enciendo el Beeper
                    __turnOnBeeper();
                    // Cambio de estado
                    alarm->state = FIRST_BEEP;
                    break;

                case FIRST_BEEP:
                	// Refresco el Timer
					FSM_RefreshTimer( &(alarm->timer) );
                    // Si el timer está funcionando
                    if( timerIsWorking( &(alarm->timer) ) )
                        break;
                    // Si el timer terminó
                    else if( timerJustFinished( &(alarm->timer) ) ){
                        // Disparo el timer para el espacio entre beeps
                        startTimer( &(alarm->timer), DOUBLE_BEEP_SPACE_TIME );
                        // Apago el Beeper
                        __turnOffBeeper();
                        // Cambio de estado
                        alarm->state = FIRST_SPACE;
                    }
                    break;

                case FIRST_SPACE:
                	// Refresco el Timer
					FSM_RefreshTimer( &(alarm->timer) );
                    // Si el timer está funcionando
                    if( timerIsWorking( &(alarm->timer) ) )
                        break;
                    // Si el timer terminó
                    else if( timerJustFinished( &(alarm->timer) ) ){
                        // Disparo el timer para el segundo beep
                        startTimer( &(alarm->timer), DOUBLE_BEEP_TIME );
                        // Enciendo el Beeper
                        __turnOnBeeper();
                        // Cambio de estado
                        alarm->state = SECOND_BEEP;
                    }
                    break;

                case SECOND_BEEP:
                	// Refresco el Timer
					FSM_RefreshTimer( &(alarm->timer) );
                    // Si el timer está funcionando
                    if( timerIsWorking( &(alarm->timer) ) )
                        break;
                    // Si el timer terminó
                    else if( timerJustFinished( &(alarm->timer) ) ){
                        // Disparo el timer para el resto del ciclo
                        startTimer( &(alarm->timer), TL_FOR_DOUBLE_BEEP );
                        // Apago el Beeper
                        __turnOffBeeper();
                        // Cambio de estado
                        alarm->state = COMPLETING_CYCLE;
                    }
                    break;

                case COMPLETING_CYCLE:
                	// Refresco el Timer
                	FSM_RefreshTimer( &(alarm->timer) );
                    // Si el timer está funcionando
                    if( timerIsWorking( &(alarm->timer) ) )
                        break;
                    // Si el timer terminó
                    else if( timerJustFinished( &(alarm->timer) ) ){
                        // Disparo el timer para el primer beep (repito el ciclo)
                        startTimer( &(alarm->timer), DOUBLE_BEEP_TIME );
                        // Enciendo el Beeper
                        __turnOnBeeper();
                        // Cambio de estado
                        alarm->state = FIRST_BEEP;
                    }
                    break;

                default:
                    // Si no tiene estado, le asigno IDLE
                    alarm->state = IDLE;
                    break;

            }
            break;

        // Para el tipo Triple Beep
        case TRIPLE_BEEP:
            // Según el estado
            switch( alarm->state ){
                
                // Si no empezó
                case IDLE:
                    // Disparo el timer para un beep
                    startTimer( &(alarm->timer), TRIPLE_BEEP_TIME );
                    // Enciendo el Beeper
                    __turnOnBeeper();
                    // Cambio de estado
                    alarm->state = FIRST_BEEP;
                    break;

                case FIRST_BEEP:
                	// Refresco el Timer
					FSM_RefreshTimer( &(alarm->timer) );
                    // Si el timer está funcionando
                    if( timerIsWorking( &(alarm->timer) ) )
                        break;
                    // Si el timer terminó
                    else if( timerJustFinished( &(alarm->timer) ) ){
                        // Disparo el timer para el espacio entre beeps
                        startTimer( &(alarm->timer), TRIPLE_BEEP_SPACE_TIME );
                        // Apago el Beeper
                        __turnOffBeeper();
                        // Cambio de estado
                        alarm->state = FIRST_SPACE;
                    }
                    break;

                case FIRST_SPACE:
                	// Refresco el Timer
					FSM_RefreshTimer( &(alarm->timer) );
                    // Si el timer está funcionando
                    if( timerIsWorking( &(alarm->timer) ) )
                        break;
                    // Si el timer terminó
                    else if( timerJustFinished( &(alarm->timer) ) ){
                        // Disparo el timer para el segundo beep
                        startTimer( &(alarm->timer), TRIPLE_BEEP_TIME );
                        // Enciendo el Beeper
                        __turnOnBeeper();
                        // Cambio de estado
                        alarm->state = SECOND_BEEP;
                    }
                    break;

                case SECOND_BEEP:
                	// Refresco el Timer
					FSM_RefreshTimer( &(alarm->timer) );
                    // Si el timer está funcionando
                    if( timerIsWorking( &(alarm->timer) ) )
                        break;
                    // Si el timer terminó
                    else if( timerJustFinished( &(alarm->timer) ) ){
                        // Disparo el timer para el espacio entre beeps
                        startTimer( &(alarm->timer), TRIPLE_BEEP_SPACE_TIME );
                        // Apago el Beeper
                        __turnOffBeeper();
                        // Cambio de estado
                        alarm->state = SECOND_SPACE;
                    }
                    break;

                case SECOND_SPACE:
                	// Refresco el Timer
                	FSM_RefreshTimer( &(alarm->timer) );
                    // Si el timer está funcionando
                    if( timerIsWorking( &(alarm->timer) ) )
                        break;
                    // Si el timer terminó
                    else if( timerJustFinished( &(alarm->timer) ) ){
                        // Disparo el timer para el tercer beep
                        startTimer( &(alarm->timer), TRIPLE_BEEP_TIME );
                        // Enciendo el Beeper
                        __turnOnBeeper();
                        // Cambio de estado
                        alarm->state = THIRD_BEEP;
                    }
                    break;

                case THIRD_BEEP:
                	// Refresco el Timer
					FSM_RefreshTimer( &(alarm->timer) );
                    // Si el timer está funcionando
                    if( timerIsWorking( &(alarm->timer) ) )
                        break;
                    // Si el timer terminó
                    else if( timerJustFinished( &(alarm->timer) ) ){
                        // Disparo el timer para el resto del ciclo
                        startTimer( &(alarm->timer), TL_FOR_TRIPLE_BEEP );
                        // Apago el Beeper
                        __turnOffBeeper();
                        // Cambio de estado
                        alarm->state = COMPLETING_CYCLE;
                    }
                    break;

                case COMPLETING_CYCLE:
                	// Refresco el Timer
					FSM_RefreshTimer( &(alarm->timer) );
                    // Si el timer está funcionando
                    if( timerIsWorking( &(alarm->timer) ) )
                        break;
                    // Si el timer terminó
                    else if( timerJustFinished( &(alarm->timer) ) ){
                        // Disparo el timer para el primer beep (repito el ciclo)
                        startTimer( &(alarm->timer), TRIPLE_BEEP_TIME );
                        // Enciendo el Beeper
                        __turnOnBeeper();
                        // Cambio de estado
                        alarm->state = FIRST_BEEP;
                    }
                    break;

                default:
                    // Si no tiene estado, le asigno IDLE
                    alarm->state = IDLE;
                    break;

            }
            break;

        // Para el tipo Beep Largo
        case SINGLE_LONG_BEEP:
            // Según el estado
            switch( alarm->state ){
                
                // Si no empezó
                case IDLE:
                    // Disparo el timer para un beep largo
                    startTimer( &(alarm->timer), LONG_BEEP_TIME );
                    // Enciendo el Beeper
                    __turnOnBeeper();
                    // Cambio de estado
                    alarm->state = FIRST_BEEP;
                    break;

                case FIRST_BEEP:
                	// Refresco el Timer
					FSM_RefreshTimer( &(alarm->timer) );
                    // Si el timer está funcionando
                    if( timerIsWorking( &(alarm->timer) ) )
                        break;
                    // Si el timer terminó
                    else if( timerJustFinished( &(alarm->timer) ) ){
                        // Disparo el timer para el resto del ciclo
                        startTimer( &(alarm->timer), TL_FOR_LONG_BEEP );
                        // Apago el Beeper
                        __turnOffBeeper();
                        // Cambio de estado
                        alarm->state = COMPLETING_CYCLE;
                    }
                    break;

                case COMPLETING_CYCLE:
                	// Refresco el Timer
					FSM_RefreshTimer( &(alarm->timer) );
                    // Si el timer está funcionando
                    if( timerIsWorking( &(alarm->timer) ) )
                        break;
                    // Si el timer terminó
                    else if( timerJustFinished( &(alarm->timer) ) ){
                        // Disparo el timer para el primer beep largo (repito el ciclo)
                        startTimer( &(alarm->timer), LONG_BEEP_TIME );
                        // Enciendo el Beeper
                        __turnOnBeeper();
                        // Cambio de estado
                        alarm->state = FIRST_BEEP;
                    }
                    break;

                default:
                    // Si no tiene estado, le asigno IDLE
                    alarm->state = IDLE;
                    break;

            }
            break;

        default:
            // Si no tiene tipo, le asigno NONE
            alarm->type = NONE;
            break;
    
    }

    return;

}

// Seteo la alarma
void setAlarm( Alarm *alarm, AlarmType type ){

    // Seteo el tipo de alarma
    alarm->type = type;

    // Paro el timer previo
    stopTimer( &(alarm->timer) );

}
// Reseteo la alarma
void resetAlarm( Alarm *alarm ){

    // Reseteo el tipo de alarma
    alarm->type = NONE;

    // Reseteo el estado de la alarma
    alarm->state = IDLE;

    // Paro el timer previo
    stopTimer( &(alarm->timer) );

}

// Encender el Beeper
void __turnOnBeeper( void ){
	HAL_GPIO_WritePin(PORT_BUZZER, PIN_BUZZER, GPIO_PIN_SET);
}
// Apagar el Beeper
void __turnOffBeeper( void ){
	HAL_GPIO_WritePin(PORT_BUZZER, PIN_BUZZER, GPIO_PIN_RESET);
}
