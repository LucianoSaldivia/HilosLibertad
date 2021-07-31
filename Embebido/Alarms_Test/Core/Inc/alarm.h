#ifndef _ALARM_H_
#define _ALARM_H_

    //#include <stdint.h>
    #include "timers.h"
	#include "main.h"
	#include "pin_connections.h"

    #define DEFAULT_BEEP_TIME       (uint16_t) 60
    #define DEFAULT_BEEP_SPACE_TIME (uint16_t) 140
    #define DEFAULT_LONG_BEEP_TIME  (uint16_t) 500

    #define TL_SINGLE_BEEP          (uint16_t) 800
    #define TL_DOUBLE_BEEP          (uint16_t) 1000
    #define TL_TRIPLE_BEEP          (uint16_t) 1200
    #define TL_QUADRUPLE_BEEP       (uint16_t) 1400
    #define TL_LONG_SINGLE_BEEP     (uint16_t) 1000


	#ifndef _SEQUENCES_AS_EXTERN_
	#define _SEQUENCES_AS_EXTERN_

		extern uint16_t single_beep_seq[];
		extern uint16_t double_beep_seq[];
		extern uint16_t triple_beep_seq[];
		extern uint16_t quadruple_beep_seq[];
		extern uint16_t long_single_beep_seq[];

	#endif


    typedef enum{
        NONE,
        SINGLE_BEEP,
        DOUBLE_BEEP,
        TRIPLE_BEEP,
        QUADRUPLE_BEEP,
        LONG_SINGLE_BEEP
    } AlarmType;

    typedef struct{
        uint16_t *seq;
        uint8_t size_of_sequence;
        uint8_t step_in_sequence;
        AlarmType type;
        Timer timer;
    } Alarm;

    // Inicializo la Alarma
    void initAlarm( Alarm *alarm );
    // FSM de la Alarma
    void FSM_Alarm( Alarm *alarm );

    // Seteo la alarma
    void setAlarm( Alarm *alarm, AlarmType type );
    // Reseteo la alarma
    void resetAlarm( Alarm *alarm );

    // Encender el Beeper
    void __turnOnBeeper( void );
    // Apagar el Beeper
    void __turnOffBeeper( void );

#endif
