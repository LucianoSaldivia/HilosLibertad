#include <stdio.h>
#include "debouncer.h"

// Inicializar el flag del timer
void initDebouncer_TimerInterruptionFlag( Debouncer_TimerInterruptionFlag *TIM_flag ){
    TIM_flag->timer_finished = 0;
}
// Inicializar el lector
void initDebouncer( debouncer *d, TIM_HandleTypeDef *htim ){
    // Inicializo el puntero al handler del TIMER
	d->htim = htim;

	// Recorro las lecturas en crudo, seteando en INIT_STATE
    for( d->i = 0; d->i < SAMPLES_TO_VALIDATE; d->i ++ ){
        d->raw[ d->i ].sample = INIT_STATES;
    }
    // Inicializo el índice
    d->i = 0;

    // Inicializo la lectura debounceadas según last_reading
    d->debounced.sample = INIT_STATES;

    // Seteo el estado inicial
    d->state = READING;
    // Inicializo el último systick
    d->__last_systick = HAL_GetTick();
}

// FSM del lector
void FSM_Debouncer( debouncer *d, Debouncer_TimerInterruptionFlag *TIM_flag ){   

	// chequeo el systick
	uint32_t new_systick = HAL_GetTick();

    switch( d->state ){
        case WAITING_NEXT_SYSTICK:

            // Si no pasó TIME_TO_CAPTURE_MS milisegundos, me voy (casi siempre)
            if( new_systick - d->__last_systick < TIME_TO_CAPTURE_MS ){
                break;
            }
            // Si pasó TIME_TO_CAPTURE_MS milisegundos (1 vez cada TIME_TO_CAPTURE_MS milisegundos)
            else{
                // Actualizo el último systick
                d->__last_systick = new_systick;
                // Fuerzo una nueva lectura
                d->state = READING;
            }
            break;

        case READING:
            // Tomo nuevas lecturas en crudo
            _readRawInputs( d, TIM_flag );
            // Fuerzo el cálculo de un nuevo debounce
            d->state = DEBOUNCING;
            break;

        case DEBOUNCING:
            // Hago la lógica de debounce
            _debounce( d );
            // Actualizo el systick
            d->__last_systick = new_systick;
            // Espero al próximo systick
            d->state = WAITING_NEXT_SYSTICK;
            break;
        
        default:
            // Por default, espero al próximo systick
        	d->state = WAITING_NEXT_SYSTICK;
            break;
    }
}

// Obtener las lecturas limpias
sample getDebouncedSample( debouncer *d ){
    return d->debounced;
}

// Escribo A y B (en la salida tienen que estar negados)
void _writeAB( uint8_t a, uint8_t b ){
    HAL_GPIO_WritePin( PORT_A, PIN_A, !(a) );
    HAL_GPIO_WritePin( PORT_B, PIN_B, !(b) );
}

// Leer de las entradas en crudo
void _readRawInputs( debouncer *d, Debouncer_TimerInterruptionFlag *TIM_flag ){
    // Corrimiento de lecturas
    uint8_t offset;
    
    // Inicializo las nuevas lecturas
    d->raw[d->i].sample = 0;

    // Si alguna placa está definida, entro a la lectura
    #ifdef AT_LEAST_ONE_BOARD
        // Leo con AB = 00
        _writeAB(0, 0);
        offset = 0;
        // Inicio el timer con el tiempo entre escritura y lectura
        HAL_TIM_Base_Start_IT ( d->htim );
        /* Espero hasta que la interrupción del timer levante el flag */
        while( TIM_flag->timer_finished != 1 ){

        }
        // Bajo el flag para uso futuro
        TIM_flag->timer_finished = 0;

        // Lecturas las placas definidas
        #if defined(BOARD0)
            d->raw[d->i].nibbles.W0 |= HAL_GPIO_ReadPin( PORT_W0, PIN_W0 ) << offset;
            d->raw[d->i].nibbles.X0 |= HAL_GPIO_ReadPin( PORT_X0, PIN_X0 ) << offset;
            d->raw[d->i].nibbles.Y0 |= HAL_GPIO_ReadPin( PORT_Y0, PIN_Y0 ) << offset;
            d->raw[d->i].nibbles.Z0 |= HAL_GPIO_ReadPin( PORT_Z0, PIN_Z0 ) << offset;
        #endif /* BOARD0 */
        #if defined(BOARD1)
            d->raw[d->i].nibbles.W1 |= HAL_GPIO_ReadPin( PORT_W1, PIN_W1 ) << offset;
            d->raw[d->i].nibbles.X1 |= HAL_GPIO_ReadPin( PORT_X1, PIN_X1 ) << offset;
            d->raw[d->i].nibbles.Y1 |= HAL_GPIO_ReadPin( PORT_Y1, PIN_Y1 ) << offset;
            d->raw[d->i].nibbles.Z1 |= HAL_GPIO_ReadPin( PORT_Z1, PIN_Z1 ) << offset;
        #endif /* BOARD1 */
        #if defined(BOARD2)
            d->raw[d->i].nibbles.W2 |= HAL_GPIO_ReadPin( PORT_W2, PIN_W2 ) << offset;
            d->raw[d->i].nibbles.X2 |= HAL_GPIO_ReadPin( PORT_X2, PIN_X2 ) << offset;
            d->raw[d->i].nibbles.Y2 |= HAL_GPIO_ReadPin( PORT_Y2, PIN_Y2 ) << offset;
            d->raw[d->i].nibbles.Z2 |= HAL_GPIO_ReadPin( PORT_Z2, PIN_Z2 ) << offset;
        #endif /* BOARD2 */
        #if defined(BOARD3)
            d->raw[d->i].nibbles.W3 |= HAL_GPIO_ReadPin( PORT_W3, PIN_W3 ) << offset;
            d->raw[d->i].nibbles.X3 |= HAL_GPIO_ReadPin( PORT_X3, PIN_X3 ) << offset;
            d->raw[d->i].nibbles.Y3 |= HAL_GPIO_ReadPin( PORT_Y3, PIN_Y3 ) << offset;
            d->raw[d->i].nibbles.Z3 |= HAL_GPIO_ReadPin( PORT_Z3, PIN_Z3 ) << offset;
        #endif /* BOARD3 */
 

        // Leo con AB = 01
        _writeAB(0, 1);
        offset = 1;
        // Inicio el timer con el tiempo entre escritura y lectura
        HAL_TIM_Base_Start_IT ( d->htim );
        /* Espero hasta que la interrupción del timer levante el flag nuevamente */
        while( TIM_flag->timer_finished != 1 ){

        }
        // Bajo el flag para uso futuro
        TIM_flag->timer_finished = 0;

        // Lecturas las placas definidas
        #if defined(BOARD0)
            d->raw[d->i].nibbles.W0 |= HAL_GPIO_ReadPin( PORT_W0, PIN_W0 ) << offset;
            d->raw[d->i].nibbles.X0 |= HAL_GPIO_ReadPin( PORT_X0, PIN_X0 ) << offset;
            d->raw[d->i].nibbles.Y0 |= HAL_GPIO_ReadPin( PORT_Y0, PIN_Y0 ) << offset;
            d->raw[d->i].nibbles.Z0 |= HAL_GPIO_ReadPin( PORT_Z0, PIN_Z0 ) << offset;
        #endif /* BOARD0 */
        #if defined(BOARD1)
            d->raw[d->i].nibbles.W1 |= HAL_GPIO_ReadPin( PORT_W1, PIN_W1 ) << offset;
            d->raw[d->i].nibbles.X1 |= HAL_GPIO_ReadPin( PORT_X1, PIN_X1 ) << offset;
            d->raw[d->i].nibbles.Y1 |= HAL_GPIO_ReadPin( PORT_Y1, PIN_Y1 ) << offset;
            d->raw[d->i].nibbles.Z1 |= HAL_GPIO_ReadPin( PORT_Z1, PIN_Z1 ) << offset;
        #endif /* BOARD1 */
        #if defined(BOARD2)
            d->raw[d->i].nibbles.W2 |= HAL_GPIO_ReadPin( PORT_W2, PIN_W2 ) << offset;
            d->raw[d->i].nibbles.X2 |= HAL_GPIO_ReadPin( PORT_X2, PIN_X2 ) << offset;
            d->raw[d->i].nibbles.Y2 |= HAL_GPIO_ReadPin( PORT_Y2, PIN_Y2 ) << offset;
            d->raw[d->i].nibbles.Z2 |= HAL_GPIO_ReadPin( PORT_Z2, PIN_Z2 ) << offset;
        #endif /* BOARD2 */
        #if defined(BOARD3)
            d->raw[d->i].nibbles.W3 |= HAL_GPIO_ReadPin( PORT_W3, PIN_W3 ) << offset;
            d->raw[d->i].nibbles.X3 |= HAL_GPIO_ReadPin( PORT_X3, PIN_X3 ) << offset;
            d->raw[d->i].nibbles.Y3 |= HAL_GPIO_ReadPin( PORT_Y3, PIN_Y3 ) << offset;
            d->raw[d->i].nibbles.Z3 |= HAL_GPIO_ReadPin( PORT_Z3, PIN_Z3 ) << offset;
        #endif /* BOARD3 */


        // Leo con AB = 10
        _writeAB(1, 0);
        offset = 2;
        // Inicio el timer con el tiempo entre escritura y lectura
        HAL_TIM_Base_Start_IT ( d->htim );
        /* Espero hasta que la interrupción del timer levante el flag nuevamente */
        while( TIM_flag->timer_finished != 1 ){

        }
        // Bajo el flag para uso futuro
        TIM_flag->timer_finished = 0;

        // Lecturas las placas definidas
        #if defined(BOARD0)
            d->raw[d->i].nibbles.W0 |= HAL_GPIO_ReadPin( PORT_W0, PIN_W0 ) << offset;
            d->raw[d->i].nibbles.X0 |= HAL_GPIO_ReadPin( PORT_X0, PIN_X0 ) << offset;
            d->raw[d->i].nibbles.Y0 |= HAL_GPIO_ReadPin( PORT_Y0, PIN_Y0 ) << offset;
            d->raw[d->i].nibbles.Z0 |= HAL_GPIO_ReadPin( PORT_Z0, PIN_Z0 ) << offset;
        #endif /* BOARD0 */
        #if defined(BOARD1)
            d->raw[d->i].nibbles.W1 |= HAL_GPIO_ReadPin( PORT_W1, PIN_W1 ) << offset;
            d->raw[d->i].nibbles.X1 |= HAL_GPIO_ReadPin( PORT_X1, PIN_X1 ) << offset;
            d->raw[d->i].nibbles.Y1 |= HAL_GPIO_ReadPin( PORT_Y1, PIN_Y1 ) << offset;
            d->raw[d->i].nibbles.Z1 |= HAL_GPIO_ReadPin( PORT_Z1, PIN_Z1 ) << offset;
        #endif /* BOARD1 */
        #if defined(BOARD2)
            d->raw[d->i].nibbles.W2 |= HAL_GPIO_ReadPin( PORT_W2, PIN_W2 ) << offset;
            d->raw[d->i].nibbles.X2 |= HAL_GPIO_ReadPin( PORT_X2, PIN_X2 ) << offset;
            d->raw[d->i].nibbles.Y2 |= HAL_GPIO_ReadPin( PORT_Y2, PIN_Y2 ) << offset;
            d->raw[d->i].nibbles.Z2 |= HAL_GPIO_ReadPin( PORT_Z2, PIN_Z2 ) << offset;
        #endif /* BOARD2 */
        #if defined(BOARD3)
            d->raw[d->i].nibbles.W3 |= HAL_GPIO_ReadPin( PORT_W3, PIN_W3 ) << offset;
            d->raw[d->i].nibbles.X3 |= HAL_GPIO_ReadPin( PORT_X3, PIN_X3 ) << offset;
            d->raw[d->i].nibbles.Y3 |= HAL_GPIO_ReadPin( PORT_Y3, PIN_Y3 ) << offset;
            d->raw[d->i].nibbles.Z3 |= HAL_GPIO_ReadPin( PORT_Z3, PIN_Z3 ) << offset;
        #endif /* BOARD3 */


        // Leo con AB = 11
        _writeAB(1, 1);
        offset = 3;
        // Inicio el timer con el tiempo entre escritura y lectura
        HAL_TIM_Base_Start_IT ( d->htim );
        /* Espero hasta que la interrupción del timer levante el flag */
        while( TIM_flag->timer_finished != 1 ){

        }
        // Bajo el flag para uso futuro
        TIM_flag->timer_finished = 0;

        // Lecturas las placas definidas
        #if defined(BOARD0)
            d->raw[d->i].nibbles.W0 |= HAL_GPIO_ReadPin( PORT_W0, PIN_W0 ) << offset;
            d->raw[d->i].nibbles.X0 |= HAL_GPIO_ReadPin( PORT_X0, PIN_X0 ) << offset;
            d->raw[d->i].nibbles.Y0 |= HAL_GPIO_ReadPin( PORT_Y0, PIN_Y0 ) << offset;
            d->raw[d->i].nibbles.Z0 |= HAL_GPIO_ReadPin( PORT_Z0, PIN_Z0 ) << offset;
        #endif /* BOARD0 */
        #if defined(BOARD1)
            d->raw[d->i].nibbles.W1 |= HAL_GPIO_ReadPin( PORT_W1, PIN_W1 ) << offset;
            d->raw[d->i].nibbles.X1 |= HAL_GPIO_ReadPin( PORT_X1, PIN_X1 ) << offset;
            d->raw[d->i].nibbles.Y1 |= HAL_GPIO_ReadPin( PORT_Y1, PIN_Y1 ) << offset;
            d->raw[d->i].nibbles.Z1 |= HAL_GPIO_ReadPin( PORT_Z1, PIN_Z1 ) << offset;
        #endif /* BOARD1 */
        #if defined(BOARD2)
            d->raw[d->i].nibbles.W2 |= HAL_GPIO_ReadPin( PORT_W2, PIN_W2 ) << offset;
            d->raw[d->i].nibbles.X2 |= HAL_GPIO_ReadPin( PORT_X2, PIN_X2 ) << offset;
            d->raw[d->i].nibbles.Y2 |= HAL_GPIO_ReadPin( PORT_Y2, PIN_Y2 ) << offset;
            d->raw[d->i].nibbles.Z2 |= HAL_GPIO_ReadPin( PORT_Z2, PIN_Z2 ) << offset;
        #endif /* BOARD2 */
        #if defined(BOARD3)
            d->raw[d->i].nibbles.W3 |= HAL_GPIO_ReadPin( PORT_W3, PIN_W3 ) << offset;
            d->raw[d->i].nibbles.X3 |= HAL_GPIO_ReadPin( PORT_X3, PIN_X3 ) << offset;
            d->raw[d->i].nibbles.Y3 |= HAL_GPIO_ReadPin( PORT_Y3, PIN_Y3 ) << offset;
            d->raw[d->i].nibbles.Z3 |= HAL_GPIO_ReadPin( PORT_Z3, PIN_Z3 ) << offset;
        #endif /* BOARD3 */
    #endif /* AT_LEAST_ONE_BOARD */

    // Si no están TODAS las placas definidas, pongo en 0 a la que no lo esté
    #ifndef ALL_4_BOARDS 
        #ifndef BOARD0
            d->raw[d->i].boards.board0.board = 0;
        #endif /* BOARD0 */
        #ifndef BOARD1
            d->raw[d->i].boards.board1.board = 0;
        #endif /* BOARD1 */    
        #ifndef BOARD2
            d->raw[d->i].boards.board2.board = 0;
        #endif /* BOARD2 */    
        #ifndef BOARD3
            d->raw[d->i].boards.board3.board = 0;
        #endif /* BOARD3 */
    #endif /* ALL_4_BOARDS */

    // Muevo el índice
    d->i += 1;
    d->i %= SAMPLES_TO_VALIDATE;

}
// Hacer el antirrebote
void _debounce( debouncer *d ){
    /* Lógica de debounce:

    Con las lecturas en crudo guardadas cíclicamente.
        1. Si la última lectura es igual a la debounceada, no hago nada
        2. Recorro las lecturas, obteniendo acumulativamente la OR y la AND de todas las lecturas.
            Así, detecto los ceros validados (cada bit en 0 de acc_or) y unos validados (cada bit en 1 de acc_and)
        3. Asigno las nuevas detecciones

	* Aclaraciones
	1. 	Así, sólo hago el for completo, sólo cuando hay algo nuevo

	2. 	acc_or debe inicializarse con todos los bits en 0
		acc_and debe inicializarse con todos los bits en 1

	3.	La asignación debe darse de la siguiente forma
    		Como cada bit en 0 de acc_or es un 0 que tengo que asignar, hago una AND:
				debounced = debounced & acc_or.
			Como cada bit en 1 de acc_and es un 1 que tengo que asignar, hago una OR:
				debounced = debounced | acc_and.

    */

    // 1. Si la última lectura es igual a la deboucneada, no hago nada
    if( d->debounced.sample == d->raw[ d->i ].sample ){
        return;
    }

    uint64_t acc_or = 0, acc_and = -1;
    // 2. Recorro las lecturas, obteniendo acumulativamente la OR y la AND de todas las lecturas.
    for( uint16_t offset = 0; offset < SAMPLES_TO_VALIDATE; offset ++ ){
        // Obtengo los ceros validados y unos validados
        acc_or  |= d->raw[ (d->i + offset) % SAMPLES_TO_VALIDATE ].sample;
        acc_and &= d->raw[ (d->i + offset) % SAMPLES_TO_VALIDATE ].sample;
    }

    // 3. Asigno las nuevas detecciones
    d->debounced.sample &= acc_or;
    d->debounced.sample |= acc_and;
    
}


