#include "alarm.h"

// Inicializo la Alarma
void initAlarm( Alarm *alarm ){
    
    // Sin tipo
    alarm->type = NONE;

    // Estado IDLE
    alarm->state = IDLE;

    // Inicializo el timer
    configTimer( &(alarm->timer), FIRST_BEEP );

}

// FSM de la Alarma
void FSM_Alarm( Alarm *alarm ){
    
    switch( alarm->type ){

        // Si no hay tipo de alarma
        case NONE:
            // Me aseguro de dejar apagado el beeper
            turnOffBeeper();
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
                    turnOnBeeper();
                    // Cambio de estado
                    alarm->state = FIRST_BEEP;
                    break;

                case FIRST_BEEP:
                    // Si el timer está funcionando
                    if( timerIsWorking( &(alarm->timer) ) )
                        break;
                    // Si el timer terminó
                    else if( timerJustFinished( &(alarm->timer) ) ){
                        // Disparo el timer para el resto del ciclo
                        startTimer( &(alarm->timer), TL_FOR_SINGLE_BEEP );
                        // Apago el Beeper
                        turnOffBeeper();
                        // Cambio de estado
                        alarm->state = COMPLETING_CYCLE;
                    }
                    break;

                case COMPLETING_CYCLE:
                    // Si el timer está funcionando
                    if( timerIsWorking( &(alarm->timer) ) )
                        break;
                    // Si el timer terminó
                    else if( timerJustFinished( &(alarm->timer) ) ){
                        // Disparo el timer para el primer beep (repito el ciclo)
                        startTimer( &(alarm->timer), SINGLE_BEEP_TIME );
                        // Enciendo el Beeper
                        turnOnBeeper();
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
                    turnOnBeeper();
                    // Cambio de estado
                    alarm->state = FIRST_BEEP;
                    break;

                case FIRST_BEEP:
                    // Si el timer está funcionando
                    if( timerIsWorking( &(alarm->timer) ) )
                        break;
                    // Si el timer terminó
                    else if( timerJustFinished( &(alarm->timer) ) ){
                        // Disparo el timer para el espacio entre beeps
                        startTimer( &(alarm->timer), DOUBLE_BEEP_SPACE_TIME );
                        // Apago el Beeper
                        turnOffBeeper();
                        // Cambio de estado
                        alarm->state = FIRST_SPACE;
                    }
                    break;

                case FIRST_SPACE:
                    // Si el timer está funcionando
                    if( timerIsWorking( &(alarm->timer) ) )
                        break;
                    // Si el timer terminó
                    else if( timerJustFinished( &(alarm->timer) ) ){
                        // Disparo el timer para el segundo beep
                        startTimer( &(alarm->timer), DOUBLE_BEEP_TIME );
                        // Enciendo el Beeper
                        turnOnBeeper();
                        // Cambio de estado
                        alarm->state = SECOND_BEEP;
                    }
                    break;

                case SECOND_BEEP:
                    // Si el timer está funcionando
                    if( timerIsWorking( &(alarm->timer) ) )
                        break;
                    // Si el timer terminó
                    else if( timerJustFinished( &(alarm->timer) ) ){
                        // Disparo el timer para el resto del ciclo
                        startTimer( &(alarm->timer), TL_FOR_DOUBLE_BEEP );
                        // Apago el Beeper
                        turnOffBeeper();
                        // Cambio de estado
                        alarm->state = COMPLETING_CYCLE;
                    }
                    break;

                case COMPLETING_CYCLE:
                    // Si el timer está funcionando
                    if( timerIsWorking( &(alarm->timer) ) )
                        break;
                    // Si el timer terminó
                    else if( timerJustFinished( &(alarm->timer) ) ){
                        // Disparo el timer para el primer beep (repito el ciclo)
                        startTimer( &(alarm->timer), DOUBLE_BEEP_TIME );
                        // Enciendo el Beeper
                        turnOnBeeper();
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
                    turnOnBeeper();
                    // Cambio de estado
                    alarm->state = FIRST_BEEP;
                    break;

                case FIRST_BEEP:
                    // Si el timer está funcionando
                    if( timerIsWorking( &(alarm->timer) ) )
                        break;
                    // Si el timer terminó
                    else if( timerJustFinished( &(alarm->timer) ) ){
                        // Disparo el timer para el espacio entre beeps
                        startTimer( &(alarm->timer), TRIPLE_BEEP_SPACE_TIME );
                        // Apago el Beeper
                        turnOffBeeper();
                        // Cambio de estado
                        alarm->state = FIRST_SPACE;
                    }
                    break;

                case FIRST_SPACE:
                    // Si el timer está funcionando
                    if( timerIsWorking( &(alarm->timer) ) )
                        break;
                    // Si el timer terminó
                    else if( timerJustFinished( &(alarm->timer) ) ){
                        // Disparo el timer para el segundo beep
                        startTimer( &(alarm->timer), TRIPLE_BEEP_TIME );
                        // Enciendo el Beeper
                        turnOnBeeper();
                        // Cambio de estado
                        alarm->state = SECOND_BEEP;
                    }
                    break;

                case SECOND_BEEP:
                    // Si el timer está funcionando
                    if( timerIsWorking( &(alarm->timer) ) )
                        break;
                    // Si el timer terminó
                    else if( timerJustFinished( &(alarm->timer) ) ){
                        // Disparo el timer para el espacio entre beeps
                        startTimer( &(alarm->timer), TRIPLE_BEEP_SPACE_TIME );
                        // Apago el Beeper
                        turnOffBeeper();
                        // Cambio de estado
                        alarm->state = SECOND_SPACE;
                    }
                    break;

                case SECOND_SPACE:
                    // Si el timer está funcionando
                    if( timerIsWorking( &(alarm->timer) ) )
                        break;
                    // Si el timer terminó
                    else if( timerJustFinished( &(alarm->timer) ) ){
                        // Disparo el timer para el tercer beep
                        startTimer( &(alarm->timer), TRIPLE_BEEP_TIME );
                        // Enciendo el Beeper
                        turnOnBeeper();
                        // Cambio de estado
                        alarm->state = THIRD_BEEP;
                    }
                    break;

                case THIRD_BEEP:
                    // Si el timer está funcionando
                    if( timerIsWorking( &(alarm->timer) ) )
                        break;
                    // Si el timer terminó
                    else if( timerJustFinished( &(alarm->timer) ) ){
                        // Disparo el timer para el resto del ciclo
                        startTimer( &(alarm->timer), TL_FOR_TRIPLE_BEEP );
                        // Apago el Beeper
                        turnOffBeeper();
                        // Cambio de estado
                        alarm->state = COMPLETING_CYCLE;
                    }
                    break;

                case COMPLETING_CYCLE:
                    // Si el timer está funcionando
                    if( timerIsWorking( &(alarm->timer) ) )
                        break;
                    // Si el timer terminó
                    else if( timerJustFinished( &(alarm->timer) ) ){
                        // Disparo el timer para el primer beep (repito el ciclo)
                        startTimer( &(alarm->timer), TRIPLE_BEEP_TIME );
                        // Enciendo el Beeper
                        turnOnBeeper();
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
        case LONG_BEEP:
            // Según el estado
            switch( alarm->state ){
                
                // Si no empezó
                case IDLE:
                    // Disparo el timer para un beep largo
                    startTimer( &(alarm->timer), LONG_BEEP_TIME );
                    // Enciendo el Beeper
                    turnOnBeeper();
                    // Cambio de estado
                    alarm->state = FIRST_BEEP;
                    break;

                case FIRST_BEEP:
                    // Si el timer está funcionando
                    if( timerIsWorking( &(alarm->timer) ) )
                        break;
                    // Si el timer terminó
                    else if( timerJustFinished( &(alarm->timer) ) ){
                        // Disparo el timer para el resto del ciclo
                        startTimer( &(alarm->timer), TL_FOR_LONG_BEEP );
                        // Apago el Beeper
                        turnOffBeeper();
                        // Cambio de estado
                        alarm->state = COMPLETING_CYCLE;
                    }
                    break;

                case COMPLETING_CYCLE:
                    // Si el timer está funcionando
                    if( timerIsWorking( &(alarm->timer) ) )
                        break;
                    // Si el timer terminó
                    else if( timerJustFinished( &(alarm->timer) ) ){
                        // Disparo el timer para el primer beep largo (repito el ciclo)
                        startTimer( &(alarm->timer), LONG_BEEP_TIME );
                        // Enciendo el Beeper
                        turnOnBeeper();
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

// Encender el Beeper
void turnOnBeeper( void ){

}
// Apagar el Beeper
void turnOffBeeper( void );