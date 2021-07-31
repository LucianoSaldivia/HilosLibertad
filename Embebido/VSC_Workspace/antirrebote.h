#ifndef ANTIRREBOTE
#define	ANTIRREBOTE

	#include <stdint.h>

	#define _DEFAULT_MINIMUM_COUNT  20
	#define _MIN_COUNT_ACCEPTED     5

	typedef enum {
		_IDLE,
		_T_IDLE_TO_ACTIVE,
		_ACTIVE,
		_T_ACTIVE_TO_IDLE
	} _debounce_state;

	typedef enum{
		_ALREADY_REFRESHED = 0,
		_REFRESH = 1
	} _refresh_flag;

	typedef enum {
		// Botón en idle o activo
		BTN_IDLE = 0,
		BTN_ACTIVE = 1
	} btnState;

	typedef enum {
		// activo bajo (idle alto) o activo alto (idle bajo)
		ACTIVE_LOW = 0,
		ACTIVE_HIGH = 1
	} activeType;

	typedef enum{
		NEW_ACTIVE = BTN_ACTIVE,
		NEW_IDLE = BTN_IDLE,
		NO_EDGE = 35
	} edge;

	typedef struct {

			/* config fields */
		// Cantidad de lecturas necesarias para validar
		uint16_t validation_count;
		// Tipo de activo (ACTIVE_LOW o ACTIVE_HIGH)
		activeType active_type;

			/* "public" fields */
		// Estado debounceado actual
		btnState curr_state;
		uint8_t curr_pin_state;
		edge edge;

			/* "private" fields */
		// Cantidad de lecturas iguales a la actual (estables)
		uint16_t _stable_counter;
		// Estado de la FSM
		_debounce_state _fsm_state;

	} debouncedButton;

	// Inicialización del botón a debouncear
	void initDebounce( debouncedButton *s, activeType active_type, uint16_t counts_to_validate );
	// FSM del Debounce
	void FSM_Debounce( debouncedButton *s, uint32_t raw_state );

	// Lecturas rápidas del botón debounceado
	uint8_t btnIsIDLE( debouncedButton *s );
	uint8_t btnIsActive( debouncedButton *s );
	// Lecturas rápidas de flancos
	uint8_t btnEdgeToActive( debouncedButton *s );
	uint8_t btnEdgeToIDLE( debouncedButton *s );

#endif
