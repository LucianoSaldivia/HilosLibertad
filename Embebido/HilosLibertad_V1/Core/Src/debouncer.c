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

	// Recorro el vector, seteando las lecturas en
    for( d->i = 0; d->i < SAMPLES_TO_VALIDATE; d->i ++ ){
        // Inicializo las lecturas en crudo
        d->changes_in_readings[ d->i ].sample = 0;
    }

    // Inicializo la última lectura como INIT_STATE
    d->last_reading.sample = INIT_STATE;
    // Inicializo la lectura debounceadas según last_reading
    d->debounced_sample = d->last_reading;

    // Inicializo el índice
    d->i = 0;

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
            // Si pasó TIME_TO_CAPTURE_MS milisegundos (una vez por al menos 1 milisegundo)
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
sample getDebouncedSamples( debouncer *d ){
    return d->debounced_sample;
}

// Escribo A y B (en la salida tienen que estar negados)
void _writeAB( uint8_t a, uint8_t b ){
    HAL_GPIO_WritePin( PORT_A, PIN_A, !(a) );
    HAL_GPIO_WritePin( PORT_B, PIN_B, !(b) );
}

// Leer de las entradas en crudo
void _readRawInputs( debouncer *d, Debouncer_TimerInterruptionFlag *TIM_flag ){
    // Guardo las nuevas lecturas temporalmente
    sample new_reading;
    // Inicializo las nuevas lecturas
    new_reading.sample = 0;

    // Leo con AB = 00
    _writeAB(0, 0);
    // Inicio el timer con el tiempo entre escritura y lectura
    HAL_TIM_Base_Start_IT ( d->htim );
    /* Espero hasta que la interrupción del timer levante el flag */
    while( TIM_flag->timer_finished != 1 ){};
	// Bajo el flag para uso futuro
	TIM_flag->timer_finished = 0;

    /* AB = 00  => offset = 0 */
    // Board 0
    new_reading.nibbles.W0 |= HAL_GPIO_ReadPin( PORT_W0, PIN_W0 ) << 0;
    new_reading.nibbles.X0 |= HAL_GPIO_ReadPin( PORT_X0, PIN_X0 ) << 0;
    new_reading.nibbles.Y0 |= HAL_GPIO_ReadPin( PORT_Y0, PIN_Y0 ) << 0;
    new_reading.nibbles.Z0 |= HAL_GPIO_ReadPin( PORT_Z0, PIN_Z0 ) << 0;
    // Board 1
    new_reading.nibbles.W1 |= HAL_GPIO_ReadPin( PORT_W1, PIN_W1 ) << 0;
    new_reading.nibbles.X1 |= HAL_GPIO_ReadPin( PORT_X1, PIN_X1 ) << 0;
    new_reading.nibbles.Y1 |= HAL_GPIO_ReadPin( PORT_Y1, PIN_Y1 ) << 0;
    new_reading.nibbles.Z1 |= HAL_GPIO_ReadPin( PORT_Z1, PIN_Z1 ) << 0;
    // Board 2
    new_reading.nibbles.W2 |= HAL_GPIO_ReadPin( PORT_W2, PIN_W2 ) << 0;
    new_reading.nibbles.X2 |= HAL_GPIO_ReadPin( PORT_X2, PIN_X2 ) << 0;
    new_reading.nibbles.Y2 |= HAL_GPIO_ReadPin( PORT_Y2, PIN_Y2 ) << 0;
    new_reading.nibbles.Z2 |= HAL_GPIO_ReadPin( PORT_Z2, PIN_Z2 ) << 0;
    // Board 3
    new_reading.nibbles.W3 |= HAL_GPIO_ReadPin( PORT_W3, PIN_W3 ) << 0;
    new_reading.nibbles.X3 |= HAL_GPIO_ReadPin( PORT_X3, PIN_X3 ) << 0;
    new_reading.nibbles.Y3 |= HAL_GPIO_ReadPin( PORT_Y3, PIN_Y3 ) << 0;
    new_reading.nibbles.Z3 |= HAL_GPIO_ReadPin( PORT_Z3, PIN_Z3 ) << 0;
    
    
    // Leo con AB = 01
    _writeAB(0, 1);
    // Inicio el timer con el tiempo entre escritura y lectura
	HAL_TIM_Base_Start_IT ( d->htim );
    /* Espero hasta que la interrupción del timer levante el flag nuevamente */
	while( TIM_flag->timer_finished != 1 ){};
	// Bajo el flag para uso futuro
	TIM_flag->timer_finished = 0;

    /* AB = 01  => offset = 1 */
    // Board 0
    new_reading.nibbles.W0 |= HAL_GPIO_ReadPin( PORT_W0, PIN_W0 ) << 1;
    new_reading.nibbles.X0 |= HAL_GPIO_ReadPin( PORT_X0, PIN_X0 ) << 1;
    new_reading.nibbles.Y0 |= HAL_GPIO_ReadPin( PORT_Y0, PIN_Y0 ) << 1;
    new_reading.nibbles.Z0 |= HAL_GPIO_ReadPin( PORT_Z0, PIN_Z0 ) << 1;
    // Board 1
    new_reading.nibbles.W1 |= HAL_GPIO_ReadPin( PORT_W1, PIN_W1 ) << 1;
    new_reading.nibbles.X1 |= HAL_GPIO_ReadPin( PORT_X1, PIN_X1 ) << 1;
    new_reading.nibbles.Y1 |= HAL_GPIO_ReadPin( PORT_Y1, PIN_Y1 ) << 1;
    new_reading.nibbles.Z1 |= HAL_GPIO_ReadPin( PORT_Z1, PIN_Z1 ) << 1;
    // Board 2
    new_reading.nibbles.W2 |= HAL_GPIO_ReadPin( PORT_W2, PIN_W2 ) << 1;
    new_reading.nibbles.X2 |= HAL_GPIO_ReadPin( PORT_X2, PIN_X2 ) << 1;
    new_reading.nibbles.Y2 |= HAL_GPIO_ReadPin( PORT_Y2, PIN_Y2 ) << 1;
    new_reading.nibbles.Z2 |= HAL_GPIO_ReadPin( PORT_Z2, PIN_Z2 ) << 1;
    // Board 3
    new_reading.nibbles.W3 |= HAL_GPIO_ReadPin( PORT_W3, PIN_W3 ) << 1;
    new_reading.nibbles.X3 |= HAL_GPIO_ReadPin( PORT_X3, PIN_X3 ) << 1;
    new_reading.nibbles.Y3 |= HAL_GPIO_ReadPin( PORT_Y3, PIN_Y3 ) << 1;
    new_reading.nibbles.Z3 |= HAL_GPIO_ReadPin( PORT_Z3, PIN_Z3 ) << 1;
    
    // Leo con AB = 10
    _writeAB(1, 0);
    // Inicio el timer con el tiempo entre escritura y lectura
	HAL_TIM_Base_Start_IT ( d->htim );
	/* Espero hasta que la interrupción del timer levante el flag nuevamente */
    while( TIM_flag->timer_finished != 1 ){};
	// Bajo el flag para uso futuro
	TIM_flag->timer_finished = 0;

    /* AB = 10  => offset = 2 */
    // Board 0
    new_reading.nibbles.W0 |= HAL_GPIO_ReadPin( PORT_W0, PIN_W0 ) << 2;
    new_reading.nibbles.X0 |= HAL_GPIO_ReadPin( PORT_X0, PIN_X0 ) << 2;
    new_reading.nibbles.Y0 |= HAL_GPIO_ReadPin( PORT_Y0, PIN_Y0 ) << 2;
    new_reading.nibbles.Z0 |= HAL_GPIO_ReadPin( PORT_Z0, PIN_Z0 ) << 2;
    // Board 1
    new_reading.nibbles.W1 |= HAL_GPIO_ReadPin( PORT_W1, PIN_W1 ) << 2;
    new_reading.nibbles.X1 |= HAL_GPIO_ReadPin( PORT_X1, PIN_X1 ) << 2;
    new_reading.nibbles.Y1 |= HAL_GPIO_ReadPin( PORT_Y1, PIN_Y1 ) << 2;
    new_reading.nibbles.Z1 |= HAL_GPIO_ReadPin( PORT_Z1, PIN_Z1 ) << 2;
    // Board 2
    new_reading.nibbles.W2 |= HAL_GPIO_ReadPin( PORT_W2, PIN_W2 ) << 2;
    new_reading.nibbles.X2 |= HAL_GPIO_ReadPin( PORT_X2, PIN_X2 ) << 2;
    new_reading.nibbles.Y2 |= HAL_GPIO_ReadPin( PORT_Y2, PIN_Y2 ) << 2;
    new_reading.nibbles.Z2 |= HAL_GPIO_ReadPin( PORT_Z2, PIN_Z2 ) << 2;
    // Board 3
    new_reading.nibbles.W3 |= HAL_GPIO_ReadPin( PORT_W3, PIN_W3 ) << 2;
    new_reading.nibbles.X3 |= HAL_GPIO_ReadPin( PORT_X3, PIN_X3 ) << 2;
    new_reading.nibbles.Y3 |= HAL_GPIO_ReadPin( PORT_Y3, PIN_Y3 ) << 2;
    new_reading.nibbles.Z3 |= HAL_GPIO_ReadPin( PORT_Z3, PIN_Z3 ) << 2;
    
    // Leo con AB = 11
    _writeAB(1, 1);
    // Inicio el timer con el tiempo entre escritura y lectura
	HAL_TIM_Base_Start_IT ( d->htim );
	/* Espero hasta que la interrupción del timer levante el flag */
	while( TIM_flag->timer_finished != 1 ){};
    // Bajo el flag para uso futuro
    TIM_flag->timer_finished = 0;

    /* AB = 11  => offset = 3 */
    // Board 0
    new_reading.nibbles.W0 |= HAL_GPIO_ReadPin( PORT_W0, PIN_W0 ) << 3;
    new_reading.nibbles.X0 |= HAL_GPIO_ReadPin( PORT_X0, PIN_X0 ) << 3;
    new_reading.nibbles.Y0 |= HAL_GPIO_ReadPin( PORT_Y0, PIN_Y0 ) << 3;
    new_reading.nibbles.Z0 |= HAL_GPIO_ReadPin( PORT_Z0, PIN_Z0 ) << 3;
    // Board 1
    new_reading.nibbles.W1 |= HAL_GPIO_ReadPin( PORT_W1, PIN_W1 ) << 3;
    new_reading.nibbles.X1 |= HAL_GPIO_ReadPin( PORT_X1, PIN_X1 ) << 3;
    new_reading.nibbles.Y1 |= HAL_GPIO_ReadPin( PORT_Y1, PIN_Y1 ) << 3;
    new_reading.nibbles.Z1 |= HAL_GPIO_ReadPin( PORT_Z1, PIN_Z1 ) << 3;
    // Board 2
    new_reading.nibbles.W2 |= HAL_GPIO_ReadPin( PORT_W2, PIN_W2 ) << 3;
    new_reading.nibbles.X2 |= HAL_GPIO_ReadPin( PORT_X2, PIN_X2 ) << 3;
    new_reading.nibbles.Y2 |= HAL_GPIO_ReadPin( PORT_Y2, PIN_Y2 ) << 3;
    new_reading.nibbles.Z2 |= HAL_GPIO_ReadPin( PORT_Z2, PIN_Z2 ) << 3;
    // Board 3
    new_reading.nibbles.W3 |= HAL_GPIO_ReadPin( PORT_W3, PIN_W3 ) << 3;
    new_reading.nibbles.X3 |= HAL_GPIO_ReadPin( PORT_X3, PIN_X3 ) << 3;
    new_reading.nibbles.Y3 |= HAL_GPIO_ReadPin( PORT_Y3, PIN_Y3 ) << 3;
    new_reading.nibbles.Z3 |= HAL_GPIO_ReadPin( PORT_Z3, PIN_Z3 ) << 3;

    // Guardo los cambios respecto a la última lectura
    d->changes_in_readings[ d->i ].sample = d->last_reading.sample ^ new_reading.sample; 

    // Actualizo la última lectura
    d->last_reading = new_reading;
}
// Hacer el antirrebote
void _debounce( debouncer *d ){
    sample or_result;
    uint16_t i_offset;
    /* Si el vector de cambios queda en: 1 0 0 0 0 0 0 0
    => hubo un cambio, y luego se mantuvo estable. Esto para cada bit del sample.
    Entonces validaríamos un cambio, sólo cuando: 
        cambios[0] & ~( cambios[1] | cambios[2] | cambios[3] | cambios[4] ... )
    o lo que es lo mismo:
        cambios[0] & ~( or_result ),
    siendo or_result, el resultado de hacer la OR entre los demás cambios.
    */

    // Muevo el índice hacia adelante (vector circular de SAMPLES_TO_VALIDATE posiciones)
    d->i = (d->i + 1) % SAMPLES_TO_VALIDATE;
    // Ahora el índice indica el cambio más viejo

    // Inicializo la or acumulada
    or_result.sample = 0;
    // Hago la OR acumulada entre todos los cambios (menos el más viejo)
    for( i_offset = 1; i_offset < SAMPLES_TO_VALIDATE; i_offset ++ ){
        // Desde el SEGUDNO índice más viejo, hasta el más nuevo
        or_result.sample |= d->changes_in_readings[ (d->i + i_offset) % SAMPLES_TO_VALIDATE ].sample;
    }
    
    // Entonces calculo el debounced_sample, sabiendo que cambio cuando OLDEST_CHAGE and (not OR_RESULT)
    d->debounced_sample.sample ^= d->changes_in_readings[ d->i ].sample & ( ~or_result.sample );
}


