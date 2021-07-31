#ifndef _ALARM_H_
#define _ALARM_H_

    //#include <stdint.h>
    #include "timers.h"
	#include "main.h"
	#include "pin_connections.h"

    #define CYCLE_TIME              1000
    #define DEFAULT_BEEP_TIME       50
    #define DEFAULT_LONG_BEEP_TIME  500
    /* SINGLE BEEP 
    ¯¯¯¯\_______________________________/¯¯¯¯\_______________________________/
    SBT |       TL_FOR_SINGLE_BEEP     */
    #define SINGLE_BEEP_TIME        DEFAULT_BEEP_TIME
    #define TL_FOR_SINGLE_BEEP      ( CYCLE_TIME - SINGLE_BEEP_TIME )
    /* DOUBLE BEEP 
    ¯¯¯¯\____/¯¯¯¯\_____________________/¯¯¯¯\____/¯¯¯¯\_____________________/
    DBT |DBST|DBT | TL_FOR_DOUBLE_BEEP */
    #define DOUBLE_BEEP_TIME        DEFAULT_BEEP_TIME
    #define DOUBLE_BEEP_SPACE_TIME  150
    #define TL_FOR_DOUBLE_BEEP      ( CYCLE_TIME - 2*DOUBLE_BEEP_TIME - DOUBLE_BEEP_SPACE_TIME )
    /* TRIPLE BEEP 
    ¯¯¯¯\____/¯¯¯¯\____/¯¯¯¯\___________/¯¯¯¯\____/¯¯¯¯\____/¯¯¯¯\___________/
    TBT |TBST|TBT |TBST|TBT |  TL_TBT  */
    #define TRIPLE_BEEP_TIME        DEFAULT_BEEP_TIME
    #define TRIPLE_BEEP_SPACE_TIME  150
    #define TL_FOR_TRIPLE_BEEP      ( CYCLE_TIME - 3*TRIPLE_BEEP_TIME - 2*TRIPLE_BEEP_SPACE_TIME )
    /* LONG BEEP 
    ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯\___________/¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯\___________/
    LONG_BEEP_TIME          |  TL_LBT  */
    #define LONG_BEEP_TIME          DEFAULT_LONG_BEEP_TIME
    #define TL_FOR_LONG_BEEP        ( CYCLE_TIME - LONG_BEEP_TIME )

    typedef enum{
        NONE,
        SINGLE_BEEP,
        DOUBLE_BEEP,
        TRIPLE_BEEP,
        SINGLE_LONG_BEEP
    } AlarmType;

    typedef enum{
        IDLE,
        FIRST_BEEP,
        FIRST_SPACE,
        SECOND_BEEP,
        SECOND_SPACE,
        THIRD_BEEP,
        LONG_BEEP,
        COMPLETING_CYCLE
    } AlarmState;

    typedef struct{
        AlarmType type;
        AlarmState state;
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
