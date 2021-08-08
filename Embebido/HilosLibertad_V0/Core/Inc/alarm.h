#ifndef _ALARM_H_
#define _ALARM_H_

    #include "timers.h"
	#include "types.h"
	#include "pinConnections.h"

	#define _USE_LED_ALSO_

    // Tiempos por default para beeps y espacios
    #define DEFAULT_BEEP_TIME       (uint32_t) 60
    #define DEFAULT_BEEP_SPACE_TIME (uint32_t) 140
    #define DEFAULT_LONG_BEEP_TIME  (uint32_t) 450
    // Tiempos en LOW para cada tipo
    #define TL_SINGLE_BEEP          (uint32_t) 800
    #define TL_DOUBLE_BEEP          (uint32_t) 1000
    #define TL_TRIPLE_BEEP          (uint32_t) 1200
    #define TL_QUADRUPLE_BEEP       (uint32_t) 1400
    #define TL_LONG_SINGLE_BEEP     (uint32_t) 1000

    // Secuencias
    #ifndef _SEQUENCES_
    #define _SEQUENCES_
        /* SINGLE BEEP
        ¯¯¯¯\__________________________/
        DBT |      TL_SINGLE_BEEP     */
        static const uint16_t single_beep_seq[] = {
            DEFAULT_BEEP_TIME,
            TL_SINGLE_BEEP
        };

        /* DOUBLE BEEP
        ¯¯¯¯\____/¯¯¯¯\_______________________/
        DBT |DBST|DBT |    TL_DOUBLE_BEEP    */
        static const uint16_t double_beep_seq[] = {
            DEFAULT_BEEP_TIME,
            DEFAULT_BEEP_SPACE_TIME,
            DEFAULT_BEEP_TIME,
            TL_DOUBLE_BEEP
        };

        /* TRIPLE BEEP
        ¯¯¯¯\____/¯¯¯¯\____/¯¯¯¯\_____________________/
        DBT |DBST|DBT |DBST|DBT |   TL_TRIPLE_BEEP   */
        static const uint16_t triple_beep_seq[] = {
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
        static const uint16_t quadruple_beep_seq[] = {
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
        static const uint16_t long_single_beep_seq[] = {
            DEFAULT_LONG_BEEP_TIME,
            TL_LONG_SINGLE_BEEP
        };
    #endif /* _SEQUENCES_ */


    typedef enum AlarmType{
        NONE,
        SINGLE_BEEP,
        DOUBLE_BEEP,
        TRIPLE_BEEP,
        QUADRUPLE_BEEP,
        LONG_SINGLE_BEEP
    } AlarmType;

    typedef struct Alarm{
        AlarmType type;
        uint16_t *seq;
        uint8_t size_of_sequence;
        uint8_t step_in_sequence;

        Timer timer;
    } Alarm;

    // Inicializar la Alarma
    void initAlarm( Alarm *alarm );
    // FSM de la Alarma
    void FSM_Alarm( Alarm *alarm );

    // Disparar la alarma
    void fireAlarm( Alarm *alarm, AlarmType type );
    // Apagar la alarma
    void stopAlarm( Alarm *alarm );

    // Chequear estado de la alarma
    uint8_t alarmIsOn( Alarm *alarma );
    uint8_t alarmIsOff( Alarm *alarma );

    // Encender el Beeper
    void __turnOnBeeper( void );
    // Apagar el Beeper
    void __turnOffBeeper( void );


    /*  Uso ejemplo:

    main(){
        
        ...

        Alarm alarma;

        ...

        initAlarm( &alarma );

        ...

        while(1){

            ...

            FSM_Alarm( &alarma );

            ...

            fireAlarm( &alarma ); 
            stopAlarm( &alarma );

            ...
        
        }
    }
    
    */

#endif /* _ALARM_H_ */
