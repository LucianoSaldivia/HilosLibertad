#include <stdio.h>
#include "muxReader.h"


// Inicializo el lector
void initMuxReader( MuxReader *r ){

    r->state = READER_START;
    r->readings.sample = 0;
    stopTimer( &(r->timer) );
    _writeAB( 0, 0 );

}

// FSM del lector
void FSM_MuxReader( MuxReader *r ){

    FSM_RefreshTimer( &(r->timer) );

    switch( r->state ){
        // Sólo la primera vez
        case READER_START:
            // Si el timer está esperando
        	if( timerIsWaiting( &(r->timer) ) ){
        		// Disparo el timer para la siguiente lectura
        		startTimer( &(r->timer), TIME_BETWEEN_READS );
        	}
        	else if( timerJustFinished( &(r->timer) ) ){
        		// Apago el timer
        		stopTimer( &(r->timer) );
        		// Paso a leer
        		r->state = READER_WORKING_00;
        	}
            break;
        case READER_READY:
            
            // Si el timer está andando, me voy
            if( timerIsWorking( &(r->timer) ) ) 
                break;
            // Si el timer terminó
            else if( timerJustFinished( &(r->timer) ) ){
                // Apago el timer
                stopTimer( &(r->timer) );
                // No disparo el timer TIME_BETWEEN_WRITE_AND_READ, porque AB ya deberían estar en 00
                // ...
                // Voy al siguiente estado
                r->state = READER_WORKING_00;
            }

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
                startTimer( &(r->timer), TIME_BETWEEN_READS );
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
void FSM_FAST_READ_MuxReader( MuxReader *r ){

    FSM_RefreshTimer( &(r->timer) );

    switch( r->state ){
        // Sólo la primera vez
        case READER_START:
            // Si el timer está esperando
        	if( timerIsWaiting( &(r->timer) ) ){
        		// Disparo el timer para la siguiente lectura
        		startTimer( &(r->timer), TIME_BETWEEN_READS );
        	}
        	else if( timerJustFinished( &(r->timer) ) ){
        		// Apago el timer
        		stopTimer( &(r->timer) );
        		// Paso a leer
        		r->state = READER_WORKING_00;
        	}
            break;

        case READER_READY:
            // Si el timer está andando, me voy
            if( timerIsWorking( &(r->timer) ) ) 
                break;
            // Si el timer terminó
            else if( timerJustFinished( &(r->timer) ) ){
                // Apago el timer
                stopTimer( &(r->timer) );
                // No disparo el timer TIME_BETWEEN_WRITE_AND_READ, porque AB ya deberían estar en 00
                // ...
                // Voy al siguiente estado
                r->state = READER_WORKING_00;
            }

        case READER_WORKING_00:
            // Si el timer está esperando
            if( timerIsWaiting( &(r->timer) ) ){
                // Leo todas las entradas
                _read64Inputs( &(r->readings) );
                
                // Disparo el timer para la próxima lectura
                startTimer( &(r->timer), TIME_BETWEEN_READS );
                // Voy al siguiente estado
                r->state = READER_READY;
            }
            break;

        default:
            // Por default, inicializo nuevamente
            initMuxReader( r );
            break;
    }

}
void FSM_TIM_READ_MuxReader( MuxReader *r ){

    FSM_RefreshTimer( &(r->timer) );

    switch( r->state ){
        // Sólo la primera vez
        case READER_START:
            // Si el timer está esperando
        	if( timerIsWaiting( &(r->timer) ) ){
        		// Disparo el timer para la siguiente lectura
        		startTimer( &(r->timer), TIME_BETWEEN_READS );
        	}
        	else if( timerJustFinished( &(r->timer) ) ){
        		// Apago el timer
        		stopTimer( &(r->timer) );
        		// Paso a leer
        		r->state = READER_WORKING_00;
        	}
            break;

        case READER_READY:
            // Si el timer está andando, me voy
            if( timerIsWorking( &(r->timer) ) ) 
                break;
            // Si el timer terminó
            else if( timerJustFinished( &(r->timer) ) ){
                // Apago el timer
                stopTimer( &(r->timer) );
                // No disparo el timer TIME_BETWEEN_WRITE_AND_READ, porque AB ya deberían estar en 00
                // ...
                // Voy al siguiente estado
                r->state = READER_WORKING_00;
            }

        case READER_WORKING_00:
            // Si el timer está esperando
            if( timerIsWaiting( &(r->timer) ) ){
                // Leo todas las entradas
                _read64Inputs( &(r->readings) );
                
                // Disparo el timer para la próxima lectura
                startTimer( &(r->timer), TIME_BETWEEN_READS );
                // Voy al siguiente estado
                r->state = READER_READY;
            }
            break;

        default:
            // Por default, inicializo nuevamente
            initMuxReader( r );
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
void _read64Inputs( sample *readings ){
    /* AB = 00  
    => offset = 0 */
    _writeAB(0, 0);
    // Board 0
    readings->nibbles.W0 = HAL_GPIO_ReadPin( PORT_W0, PIN_W0 );
    readings->nibbles.X0 = HAL_GPIO_ReadPin( PORT_X0, PIN_X0 );
    readings->nibbles.Y0 = HAL_GPIO_ReadPin( PORT_Y0, PIN_Y0 );
    readings->nibbles.Z0 = HAL_GPIO_ReadPin( PORT_Z0, PIN_Z0 );
    // Board 1
    readings->nibbles.W1 = HAL_GPIO_ReadPin( PORT_W1, PIN_W1 );
    readings->nibbles.X1 = HAL_GPIO_ReadPin( PORT_X1, PIN_X1 );
    readings->nibbles.Y1 = HAL_GPIO_ReadPin( PORT_Y1, PIN_Y1 );
    readings->nibbles.Z1 = HAL_GPIO_ReadPin( PORT_Z1, PIN_Z1 );
    // Board 2
    readings->nibbles.W2 = HAL_GPIO_ReadPin( PORT_W2, PIN_W2 );
    readings->nibbles.X2 = HAL_GPIO_ReadPin( PORT_X2, PIN_X2 );
    readings->nibbles.Y2 = HAL_GPIO_ReadPin( PORT_Y2, PIN_Y2 );
    readings->nibbles.Z2 = HAL_GPIO_ReadPin( PORT_Z2, PIN_Z2 );
    // Board 3
    readings->nibbles.W3 = HAL_GPIO_ReadPin( PORT_W3, PIN_W3 );
    readings->nibbles.X3 = HAL_GPIO_ReadPin( PORT_X3, PIN_X3 );
    readings->nibbles.Y3 = HAL_GPIO_ReadPin( PORT_Y3, PIN_Y3 );
    readings->nibbles.Z3 = HAL_GPIO_ReadPin( PORT_Z3, PIN_Z3 );
    /* AB = 01  
    => offset = 1 */
    _writeAB(0, 1);
    // Board 0
    readings->nibbles.W0 = HAL_GPIO_ReadPin( PORT_W0, PIN_W0 ) << 1;
    readings->nibbles.X0 = HAL_GPIO_ReadPin( PORT_X0, PIN_X0 ) << 1;
    readings->nibbles.Y0 = HAL_GPIO_ReadPin( PORT_Y0, PIN_Y0 ) << 1;
    readings->nibbles.Z0 = HAL_GPIO_ReadPin( PORT_Z0, PIN_Z0 ) << 1;
    // Board 1
    readings->nibbles.W1 = HAL_GPIO_ReadPin( PORT_W1, PIN_W1 ) << 1;
    readings->nibbles.X1 = HAL_GPIO_ReadPin( PORT_X1, PIN_X1 ) << 1;
    readings->nibbles.Y1 = HAL_GPIO_ReadPin( PORT_Y1, PIN_Y1 ) << 1;
    readings->nibbles.Z1 = HAL_GPIO_ReadPin( PORT_Z1, PIN_Z1 ) << 1;
    // Board 2
    readings->nibbles.W2 = HAL_GPIO_ReadPin( PORT_W2, PIN_W2 ) << 1;
    readings->nibbles.X2 = HAL_GPIO_ReadPin( PORT_X2, PIN_X2 ) << 1;
    readings->nibbles.Y2 = HAL_GPIO_ReadPin( PORT_Y2, PIN_Y2 ) << 1;
    readings->nibbles.Z2 = HAL_GPIO_ReadPin( PORT_Z2, PIN_Z2 ) << 1;
    // Board 3
    readings->nibbles.W3 = HAL_GPIO_ReadPin( PORT_W3, PIN_W3 ) << 1;
    readings->nibbles.X3 = HAL_GPIO_ReadPin( PORT_X3, PIN_X3 ) << 1;
    readings->nibbles.Y3 = HAL_GPIO_ReadPin( PORT_Y3, PIN_Y3 ) << 1;
    readings->nibbles.Z3 = HAL_GPIO_ReadPin( PORT_Z3, PIN_Z3 ) << 1;
    /* AB = 10 
    => offset = 2 */
    _writeAB(1, 0);
    // Board 0
    readings->nibbles.W0 = HAL_GPIO_ReadPin( PORT_W0, PIN_W0 ) << 2;
    readings->nibbles.X0 = HAL_GPIO_ReadPin( PORT_X0, PIN_X0 ) << 2;
    readings->nibbles.Y0 = HAL_GPIO_ReadPin( PORT_Y0, PIN_Y0 ) << 2;
    readings->nibbles.Z0 = HAL_GPIO_ReadPin( PORT_Z0, PIN_Z0 ) << 2;
    // Board 1
    readings->nibbles.W1 = HAL_GPIO_ReadPin( PORT_W1, PIN_W1 ) << 2;
    readings->nibbles.X1 = HAL_GPIO_ReadPin( PORT_X1, PIN_X1 ) << 2;
    readings->nibbles.Y1 = HAL_GPIO_ReadPin( PORT_Y1, PIN_Y1 ) << 2;
    readings->nibbles.Z1 = HAL_GPIO_ReadPin( PORT_Z1, PIN_Z1 ) << 2;
    // Board 2
    readings->nibbles.W2 = HAL_GPIO_ReadPin( PORT_W2, PIN_W2 ) << 2;
    readings->nibbles.X2 = HAL_GPIO_ReadPin( PORT_X2, PIN_X2 ) << 2;
    readings->nibbles.Y2 = HAL_GPIO_ReadPin( PORT_Y2, PIN_Y2 ) << 2;
    readings->nibbles.Z2 = HAL_GPIO_ReadPin( PORT_Z2, PIN_Z2 ) << 2;
    // Board 3
    readings->nibbles.W3 = HAL_GPIO_ReadPin( PORT_W3, PIN_W3 ) << 2;
    readings->nibbles.X3 = HAL_GPIO_ReadPin( PORT_X3, PIN_X3 ) << 2;
    readings->nibbles.Y3 = HAL_GPIO_ReadPin( PORT_Y3, PIN_Y3 ) << 2;
    readings->nibbles.Z3 = HAL_GPIO_ReadPin( PORT_Z3, PIN_Z3 ) << 2;
    /* AB = 10  
    => offset = 3 */
    _writeAB(1, 1);
    // Board 0
    readings->nibbles.W0 = HAL_GPIO_ReadPin( PORT_W0, PIN_W0 ) << 3;
    readings->nibbles.X0 = HAL_GPIO_ReadPin( PORT_X0, PIN_X0 ) << 3;
    readings->nibbles.Y0 = HAL_GPIO_ReadPin( PORT_Y0, PIN_Y0 ) << 3;
    readings->nibbles.Z0 = HAL_GPIO_ReadPin( PORT_Z0, PIN_Z0 ) << 3;
    // Board 1
    readings->nibbles.W1 = HAL_GPIO_ReadPin( PORT_W1, PIN_W1 ) << 3;
    readings->nibbles.X1 = HAL_GPIO_ReadPin( PORT_X1, PIN_X1 ) << 3;
    readings->nibbles.Y1 = HAL_GPIO_ReadPin( PORT_Y1, PIN_Y1 ) << 3;
    readings->nibbles.Z1 = HAL_GPIO_ReadPin( PORT_Z1, PIN_Z1 ) << 3;
    // Board 2
    readings->nibbles.W2 = HAL_GPIO_ReadPin( PORT_W2, PIN_W2 ) << 3;
    readings->nibbles.X2 = HAL_GPIO_ReadPin( PORT_X2, PIN_X2 ) << 3;
    readings->nibbles.Y2 = HAL_GPIO_ReadPin( PORT_Y2, PIN_Y2 ) << 3;
    readings->nibbles.Z2 = HAL_GPIO_ReadPin( PORT_Z2, PIN_Z2 ) << 3;
    // Board 3
    readings->nibbles.W3 = HAL_GPIO_ReadPin( PORT_W3, PIN_W3 ) << 3;
    readings->nibbles.X3 = HAL_GPIO_ReadPin( PORT_X3, PIN_X3 ) << 3;
    readings->nibbles.Y3 = HAL_GPIO_ReadPin( PORT_Y3, PIN_Y3 ) << 3;
    readings->nibbles.Z3 = HAL_GPIO_ReadPin( PORT_Z3, PIN_Z3 ) << 3;
}



// Chequeo de estado
uint8_t muxReaderIsReady( MuxReader *r ){
    return (r->state == READER_READY) ? 1 : 0;
}
// Chequeo de lecturas
sample getReadings( MuxReader *r ){
    return r->readings;
}
