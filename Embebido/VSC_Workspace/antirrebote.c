#include "antirrebote.h"

// Inicialización del botón a debouncear
void initDebounce(debouncedButton *s, activeType active_type, uint16_t counts_to_validate){
    /* Inicializo todo */
        /* config fields */
    s->validation_count = (counts_to_validate < _MIN_COUNT_ACCEPTED) ? _DEFAULT_MINIMUM_COUNT : counts_to_validate;
    s->active_type = active_type;
    
        /* "public" fields */
    // Inicio en IDLE estable
    s->curr_state = BTN_IDLE;
    // Si es ACTIVE_HIGH=1, se guarda un 0, si es ACTIVE_LOW, se guarda un 1
    s->curr_pin_state = !active_type;
    s->edge = NO_EDGE;
    
        /* "private" fields */
    s->_stable_counter = 0;
    // Inicio en IDLE estable
    s->_fsm_state = _IDLE;
}

// FSM del Debounce
void FSM_Debounce(debouncedButton *s, uint32_t raw_state){
    
    /* Hecho para IDLE o ACTIVE 
        Active Type             raw_state   new_read        
            ACTIVE_LOW = 0          0           BTN_ACTIVE = 1
            ACTIVE_LOW = 0          1           BTN_IDLE = 0

            ACTIVE_HIGH = 1         0           BTN_IDLE = 0
            ACTIVE_HIGH = 1         1           BTN_ACTIVE = 1

        ~(A XOR B) = A XOR ~B
    */
    btnState new_read = ( (raw_state) ? 1 : 0 ) ^ !s->active_type;
	
    // FSM de Antirrebote
    switch ( s->_fsm_state ){

        case _IDLE:
            // Aseguro bajar el flanco
            s->edge = NO_EDGE;

            // Si detecto ACTIVO
            if( new_read == BTN_ACTIVE ){
                // Inicio el contador
                s->_stable_counter = 1;
                
                // Paso a debouncear la transición
                s->_fsm_state = _T_IDLE_TO_ACTIVE;
            }
            // Sino, no hago nada más
            break;
        
        case _T_IDLE_TO_ACTIVE:
            // Si sigo leyendo activo
            if( new_read == BTN_ACTIVE ){
                // Cuento la lectura
                s->_stable_counter ++;

                // Si llegué a la cuenta, valido ACTIVE
                if( s->_stable_counter >= s->validation_count ){
                    s->curr_state = BTN_ACTIVE;
                    s->curr_pin_state = new_read;
                    s->edge = NEW_ACTIVE;
                    
                    s->_stable_counter = 0;
                    s->_fsm_state = _ACTIVE;
                }
                // Sino, no hago nada más
            }
            // Sino, fueron rebotes
            else{
                // Reseteo el contador
                s->_stable_counter = 0;
                // Vuelvo a idle
                s->_fsm_state = _IDLE;
            }
            break;
        
        case _ACTIVE:
            // Sino, aseguro bajar el flanco
            s->edge = NO_EDGE;

            // Si detecto IDLE
            if( new_read == BTN_IDLE ){
                // Inicio el contador
                s->_stable_counter = 1;
                
                // Paso a debouncear la transición
                s->_fsm_state = _T_ACTIVE_TO_IDLE;
            }
            // Sino, no hago nada más
            break;
        
        case _T_ACTIVE_TO_IDLE:
            // Si sigo leyendo idle
            if( new_read == BTN_IDLE ){
                // Cuento la lectura
                s->_stable_counter ++;

                // Si llegué a la cuenta, valido IDLE
                if( s->_stable_counter >= s->validation_count ){
                    s->curr_state = BTN_IDLE;
                    s->curr_pin_state = new_read;
                    s->edge = NEW_IDLE;
                    
                    s->_stable_counter = 0;
                    s->_fsm_state = _IDLE;
                }
                // Sino, no hago nada más
            }
            // Sino, fueron rebotes
            else{
                // Reseteo el contador
                s->_stable_counter = 0;
                // Vuelvo a active
                s->_fsm_state = _ACTIVE;
            }
            break;
        
        default:
            // Por default, voy a idle
            s->_fsm_state = _IDLE;
            break;

    }

}


// Lecturas rápidas del botón debounceado
uint8_t btnIsIDLE(debouncedButton *s){

    return (s->curr_state == BTN_IDLE) ? 1 : 0;

}
uint8_t btnIsActive(debouncedButton *s){

    return (s->curr_state == BTN_ACTIVE) ? 1 : 0;

}
// Lecturas rápidas de flancos
uint8_t btnEdgeToActive( debouncedButton *s ){

	return (s->edge == NEW_ACTIVE) ? 1 : 0 ;

}
uint8_t btnEdgeToIDLE( debouncedButton *s ){

	return (s->edge == NEW_IDLE) ? 1 : 0 ;

}
