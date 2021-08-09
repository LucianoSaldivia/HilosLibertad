#include "alarm.h"


// Inicializo la Alarma
void initAlarm( Alarm *alarm ){
    
    // Sin tipo
    alarm->type = NONE;
    
    // Reseteo la secuencia
    alarm->seq = NULL;
    alarm->size_of_sequence = 0;
    alarm->step_in_sequence = 0;

    // Paro el timer previo
    stopTimer( &(alarm->timer) );

    // Me aseguro de dejar apagado el beeper
    __turnOffBeeper();

}

// FSM de la Alarma
void FSM_Alarm( Alarm *alarm ){
    
    switch( alarm->type ){

        // Si no hay tipo de alarma
        case NONE:
            break;

        case SINGLE_BEEP:
        case DOUBLE_BEEP:
        case TRIPLE_BEEP:
        case QUADRUPLE_BEEP:
        case LONG_SINGLE_BEEP:

            // Refresco el Timer
            FSM_RefreshTimer( &(alarm->timer) );

            // Si el timer sigue funcionando, me voy
            if( timerIsWorking( &(alarm->timer) ) )
                break;
            // Si el timer terminó
            else if( timerJustFinished( &(alarm->timer) ) ){
                // Incremento el paso
                alarm->step_in_sequence ++;
                alarm->step_in_sequence %= alarm->size_of_sequence;
                
                // Si es par enciendo el beeper, si es impar lo apago
                ( alarm->step_in_sequence % 2 == 0 ) ? __turnOnBeeper() : __turnOffBeeper();
                // Disparo el timer con el nuevo tiempo
                startTimer( &(alarm->timer), alarm->seq[alarm->step_in_sequence] );


            }
            // Si el timer no empezó (sólo entra la primera vez)
            else if( timerIsWaiting( &(alarm->timer) ) ){
                // Primera vez, enciendo el Beeper
                __turnOnBeeper();
                // Disparo el timer
                startTimer( &(alarm->timer), alarm->seq[0] );
            }
            break;

        default:
            // Por default, inicializo nuevamente
            initAlarm( alarm );
            break;

    }

    return;

}

// Disparar la alarma
void fireAlarm( Alarm *alarm, AlarmType type ){
   
    // Seteo el tipo de alarma
    alarm->type = type;

    // Seteo la secuencia según el tipo de alarma elegido
    switch( type ){
        case NONE:
            alarm->seq = NULL;
            alarm->size_of_sequence = 0;
            break;
        
        case SINGLE_BEEP:
            alarm->seq = (uint16_t *) single_beep_seq;
            alarm->size_of_sequence = sizeof(single_beep_seq) / sizeof(uint16_t);
            break;

        case DOUBLE_BEEP:
            alarm->seq = (uint16_t *) double_beep_seq;
            alarm->size_of_sequence = sizeof(double_beep_seq) / sizeof(uint16_t);
            break;

        case TRIPLE_BEEP:
            alarm->seq = (uint16_t *) triple_beep_seq;
            alarm->size_of_sequence = sizeof(triple_beep_seq) / sizeof(uint16_t);
            break;
        
        case QUADRUPLE_BEEP:
            alarm->seq = (uint16_t *) quadruple_beep_seq;
            alarm->size_of_sequence = sizeof(quadruple_beep_seq) / sizeof(uint16_t);
            break;

        case LONG_SINGLE_BEEP:
            alarm->seq = (uint16_t *) long_single_beep_seq;
            alarm->size_of_sequence = sizeof(long_single_beep_seq) / sizeof(uint16_t);
            break;

        default:
            alarm->seq = NULL;
            alarm->size_of_sequence = 0;
            break;
    };

    // Reseteo el paso de la secuencia
    alarm->step_in_sequence = 0;

    // Paro el timer previo
    stopTimer( &(alarm->timer) );

}
// Apagar la alarma
void stopAlarm( Alarm *alarm ){
    // Reseteo el tipo
    alarm->type = NONE;

    // Reseteo la secuencia
    alarm->seq = NULL;
    alarm->size_of_sequence = 0;
    alarm->step_in_sequence = 0;

    // Paro el timer previo
    stopTimer( &(alarm->timer) );

    // Me aseguro de dejar apagado el beeper
    __turnOffBeeper();
}


// Chequear estado de la alarma
uint8_t alarmIsOn( Alarm *alarma ){
	return (alarma->seq == NULL) ? 0 : 1;
}
uint8_t alarmIsOff( Alarm *alarma ){
	return (alarma->seq == NULL) ? 1 : 0;
}

// Encender el Beeper
void __turnOnBeeper( void ){
	HAL_GPIO_WritePin(PORT_BUZZER, PIN_BUZZER, GPIO_PIN_SET);
	#ifdef _USE_LED_ALSO_
		HAL_GPIO_WritePin(PORT_OB_LED, PIN_OB_LED, GPIO_PIN_RESET);
	#endif /*_USE_LED_ALSO_*/
}
// Apagar el Beeper
void __turnOffBeeper( void ){
	HAL_GPIO_WritePin(PORT_BUZZER, PIN_BUZZER, GPIO_PIN_RESET);
	#ifdef _USE_LED_ALSO_
		HAL_GPIO_WritePin(PORT_OB_LED, PIN_OB_LED, GPIO_PIN_SET);
	#endif /*_USE_LED_ALSO_*/
}
