#include "alarm.h"

#ifndef _SEQUENCES_
#define _SEQUENCES_


	/* SINGLE BEEP
	¯¯¯¯\__________________________/
	DBT |      TL_SINGLE_BEEP     */
	uint16_t single_beep_seq[] = {
		DEFAULT_BEEP_TIME,
		TL_SINGLE_BEEP
	};

	/* DOUBLE BEEP
	¯¯¯¯\____/¯¯¯¯\_______________________/
	DBT |DBST|DBT |    TL_DOUBLE_BEEP    */
	uint16_t double_beep_seq[] = {
		DEFAULT_BEEP_TIME,
		DEFAULT_BEEP_SPACE_TIME,
		DEFAULT_BEEP_TIME,
		TL_DOUBLE_BEEP
	};

	/* TRIPLE BEEP
	¯¯¯¯\____/¯¯¯¯\____/¯¯¯¯\_____________________/
	DBT |DBST|DBT |DBST|DBT |   TL_TRIPLE_BEEP   */
	uint16_t triple_beep_seq[] = {
		DEFAULT_BEEP_TIME,
		DEFAULT_BEEP_SPACE_TIME,
		DEFAULT_BEEP_TIME,
		DEFAULT_BEEP_SPACE_TIME,
		DEFAULT_BEEP_TIME,
		TL_TRIPLE_BEEP
	};

	/* QUADRUPLE BEEP
	¯¯¯¯\____/¯¯¯¯\____/¯¯¯¯\____/¯¯¯¯\______________________/
	DBT |DBST|DBT |DBST|DBT |DBST|DBT |  TL_QUADRUPLE_BEEP  */
	uint16_t quadruple_beep_seq[] = {
		DEFAULT_BEEP_TIME,
		DEFAULT_BEEP_SPACE_TIME,
		DEFAULT_BEEP_TIME,
		2 * DEFAULT_BEEP_SPACE_TIME,
		DEFAULT_BEEP_TIME,
		DEFAULT_BEEP_SPACE_TIME,
		DEFAULT_BEEP_TIME,
		TL_QUADRUPLE_BEEP
	};

	/* LONG BEEP
	¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯\________________________________________/
	DLBT                    |          TL_LONG_SINGLE_BEEP          */
	uint16_t long_single_beep_seq[] = {
		DEFAULT_LONG_BEEP_TIME,
		TL_LONG_SINGLE_BEEP
	};
#endif


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

}

// FSM de la Alarma
void FSM_Alarm( Alarm *alarm ){
    
    switch( alarm->type ){

        // Si no hay tipo de alarma
        case NONE:
            // Me aseguro de dejar apagado el beeper
            __turnOffBeeper();
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
                startTimer( &(alarm->timer), 2*alarm->seq[alarm->step_in_sequence] );
            }
            break;

        default:
            // Sino hay secuencia seteada, reseteo la alarma
            resetAlarm( alarm );
            break;

    }

    return;

}

// Seteo la alarma
void setAlarm( Alarm *alarm, AlarmType type ){

    // Seteo el tipo de alarma
    alarm->type = type;

    // Seteo la secuencia según el tipo de alarma elegido
    switch( type ){
        case NONE:
            alarm->seq = NULL;
            alarm->size_of_sequence = 0;
            break;
        
        case SINGLE_BEEP:
            alarm->seq = single_beep_seq;
            alarm->size_of_sequence = sizeof(single_beep_seq) / sizeof(uint16_t);
            break;

        case DOUBLE_BEEP:
            alarm->seq = double_beep_seq;
            alarm->size_of_sequence = sizeof(double_beep_seq) / sizeof(uint16_t);
            break;

        case TRIPLE_BEEP:
            alarm->seq = triple_beep_seq;
            alarm->size_of_sequence = sizeof(triple_beep_seq) / sizeof(uint16_t);
            break;
        
        case QUADRUPLE_BEEP:
            alarm->seq = quadruple_beep_seq;
            alarm->size_of_sequence = sizeof(quadruple_beep_seq) / sizeof(uint16_t);
            break;

        case LONG_SINGLE_BEEP:
            alarm->seq = long_single_beep_seq;
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
// Reseteo la alarma
void resetAlarm( Alarm *alarm ){

    // Reseteo el tipo
    alarm->type = NONE;

    // Reseteo la secuencia
    alarm->seq = NULL;
    alarm->size_of_sequence = 0;
    alarm->step_in_sequence = 0;

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
