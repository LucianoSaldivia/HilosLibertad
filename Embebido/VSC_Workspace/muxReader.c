#include <stdio.h>
#include "muxReader.h"


// Inicializo el lector
void initMuxReader( MuxReader *r ){

    r->state = READER_READY;
    r->readings.sample = 0;
    initTimer( &(r->timer) );
    _writeAB( 0, 0 );

}

// FSM del lector
void FSM_MuxReader( MuxReader *r ){

    FSM_RefreshTimer( &(r->timer) );

    switch( r->state ){
        case READER_READY:
            
            // Si el timer está andando, me voy
            if( timerIsWorking( &(r->timer) ) ) 
                break;
            // Si el timer terminó
            if( timerJustFinished( &(r->timer) ) ){
                // Apago el timer
                stopTimer( &r->timer );
                // No disparo el timer entre lecturas, porque AB deberían estar en 00
                // ...
                // Voy al siguiente estado
                r->state = READER_WORKING_00;
            }
            // Primera vez
            else{
                // Disparo el timer para la siguiente lectura
                startTimer( &(r->timer), TIME_BETWEEM_READS );
            }
            break;

        case READER_WORKING_00:

            // Si el timer está esperando
            if( timerIsWaiting( &(r->timer) ) ){
                // Leo todas las entradas
                _read16Inputs( &(r->readings), READER_WORKING_00 );
                
                // Cambio las salidas AB a 01
                _writeAB( 0, 1 );
                // Disparo el timer para poder leer con AB = 01
                startTimer( &(r->timer), TIME_BETWEEN_WRITE_AND_READ );
                // Voy al siguiente estado
                r->state = READER_WORKING_01;
            }
            break;

        case READER_WORKING_01:
            
            // Si el timer recién termina
            if( timerJustFinished( &(r->timer) ) ){
                // Apago el timer
                stopTimer( &(r->timer) );
                // Leo todas las 16 entradas
                _read16Inputs( &(r->readings), READER_WORKING_01 );
                
                // Cambio las salidas AB a 10
                _writeAB( 1, 0 );
                // Disparo el timer para poder leer con AB = 10
                startTimer( &(r->timer), TIME_BETWEEN_WRITE_AND_READ );
                // Voy al siguiente estado
                r->state = READER_WORKING_10;
            }
            break;

        case READER_WORKING_10:
            
            // Si el timer recién termina
            if( timerJustFinished( &(r->timer) ) ){
                // Apago el timer
                stopTimer( &(r->timer) );
                // Leo todas las 16 entradas
                _read16Inputs( &(r->readings), READER_WORKING_10 );
                
                // Cambio las salidas AB a 11
                _writeAB( 1, 1 );
                // Disparo el timer para poder leer con AB = 11
                startTimer( &(r->timer), TIME_BETWEEN_WRITE_AND_READ );
                // Voy al siguiente estado
                r->state = READER_WORKING_11;
            }
            break;

        case READER_WORKING_11:
            
            // Si el timer recién termina
            if( timerJustFinished( &(r->timer) ) ){
                // Apago el timer
                stopTimer( &(r->timer) );
                // Leo todas las 16 entradas
                _read16Inputs( &(r->readings), READER_WORKING_11 );
                
                // Cambio las salidas AB a 00
                _writeAB( 0, 0 );
                // Disparo el timer para la próxima lectura
                startTimer( &(r->timer), TIME_BETWEEM_READS );
                // Voy al siguiente estado
                r->state = READER_READY;
            }
            break;
        

        default:
            // Por default, el estado será READER_READY
            r->state = READER_READY;
            break;
    }

}
// Escribo A y B (en la salida tienen que estar negados)
void _writeAB( uint8_t a, uint8_t b ){
    HAL_GPIO_WritePin( PORT_A, PIN_A, !(a) );
    HAL_GPIO_WritePin( PORT_B, PIN_B, !(b) );
}
// Leo todas las entradas
void _read16Inputs( sample *readings, MuxReaderStates state ){
    uint8_t offset;

    // Offset según el valor de AB
    switch( state ){
        case READER_WORKING_00:
            offset = 0;
            break;
        
        case READER_WORKING_01:
            offset = 1;
            break;

        case READER_WORKING_10:
            offset = 2;
            break;

        case READER_WORKING_11:
            offset = 3;
            break;

        default:
            offset = 0;
            break;
    }

    // Board 0
    readings->nibbles.W0 = HAL_GPIO_ReadPin( PORT_W0, PIN_W0 ) << offset;
    readings->nibbles.X0 = HAL_GPIO_ReadPin( PORT_X0, PIN_X0 ) << offset;
    readings->nibbles.Y0 = HAL_GPIO_ReadPin( PORT_Y0, PIN_Y0 ) << offset;
    readings->nibbles.Z0 = HAL_GPIO_ReadPin( PORT_Z0, PIN_Z0 ) << offset;
    // Board 1
    readings->nibbles.W1 = HAL_GPIO_ReadPin( PORT_W1, PIN_W1 ) << offset;
    readings->nibbles.X1 = HAL_GPIO_ReadPin( PORT_X1, PIN_X1 ) << offset;
    readings->nibbles.Y1 = HAL_GPIO_ReadPin( PORT_Y1, PIN_Y1 ) << offset;
    readings->nibbles.Z1 = HAL_GPIO_ReadPin( PORT_Z1, PIN_Z1 ) << offset;
    // Board 2
    readings->nibbles.W2 = HAL_GPIO_ReadPin( PORT_W2, PIN_W2 ) << offset;
    readings->nibbles.X2 = HAL_GPIO_ReadPin( PORT_X2, PIN_X2 ) << offset;
    readings->nibbles.Y2 = HAL_GPIO_ReadPin( PORT_Y2, PIN_Y2 ) << offset;
    readings->nibbles.Z2 = HAL_GPIO_ReadPin( PORT_Z2, PIN_Z2 ) << offset;
    // Board 3
    readings->nibbles.W3 = HAL_GPIO_ReadPin( PORT_W3, PIN_W3 ) << offset;
    readings->nibbles.X3 = HAL_GPIO_ReadPin( PORT_X3, PIN_X3 ) << offset;
    readings->nibbles.Y3 = HAL_GPIO_ReadPin( PORT_Y3, PIN_Y3 ) << offset;
    readings->nibbles.Z3 = HAL_GPIO_ReadPin( PORT_Z3, PIN_Z3 ) << offset;

}

// Chequeo de estado
uint8_t muxReaderIsReady( MuxReader *r ){
    return (r->state == READER_READY) ? 1 : 0;
}
// Chequeo de lecturas
sample getReadings( MuxReader *r ){
    return r->readings;
}