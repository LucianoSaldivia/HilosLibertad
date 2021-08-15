#include "dataSender.h"



// Inicializar la estructura de flags de interrupciones
void initDS_UartInterruptionFlags( DS_UartInterruptionFlags *flags ){
	flags->TxComplete = 0;
	flags->RxComplete = 0;
}

// Inicializar el enviador de datos
void initDataSender( DataSender *sender, UART_HandleTypeDef *uart ){
	// Seteo la UART indicada
	sender->uart = uart;

	// Contadores de Timeouts en 0
	sender->timeout_ctr = 0;
	sender->data_loss_timeouts_ctr = 0;
	// Contadores de NAKs en 0
	sender->nak_ctr = 0;
	sender->data_loss_naks_ctr = 0;
	// Contadores de Respuestas Inesperadas en 0
	sender->unex_ans_ctr = 0;
	sender->data_loss_unex_ans_ctr = 0;

	// Estado = Esperando datos
	sender->state = DS_IDLE;
	// Datos en 0
	sender->data.sample = 0;

	// Inicializo la alarma
	initAlarm( &(sender->alarma) );
	// Configuro el timer para timeouts
	configTimer( &(sender->timer), TIMEOUT_TIME );
}

// FSM del enviador de datos
void FSM_DataSender( DataSender *sender, DS_UartInterruptionFlags *flags ){

	// Refresco la alarma
	FSM_Alarm( &(sender->alarma) );
	
	// Refresco el timer de Timeout
	FSM_RefreshTimer( &(sender->timer) );

	switch( sender->state ){
		case DS_IDLE:
			break;

		case DS_SENDING_DATA:
			// Envío las lecturas cargadas
			_sendLoadedSample( sender, flags );
			// Paso a esperar el fin de la transmisión
			sender->state = DS_WAITING_FOR_TX_COMPLETE;
			break;

		case DS_WAITING_FOR_TX_COMPLETE:
			// Si se terminó de transmitir
			if( flags->TxComplete ){
				// Habilito la recepción
				_enableReceive();
				// Disparo el timer de Timeout
				startTimer( &(sender->timer), TIMEOUT_TIME );
				// Bajo el flag de Tx
				flags->TxComplete = 0;
				// Paso a esperar la respuesta
				sender->state = DS_WAITING_ANSWER;
			}
			break;

		case DS_WAITING_ANSWER:
			// Si hubo Timeout y no hubo recepción
			if( timerJustFinished( &(sender->timer) ) && !flags->RxComplete ){
				// Apago el timer
				stopTimer( &(sender->timer) );
				// Cuento el timeout
				sender->timeout_ctr ++;
				// Si llegué a la cantidad máxima de timeouts consecutivos por envío
				if( sender->timeout_ctr >= MAX_TIMEOUTS ){
					// ESTE dato se perdió, vuelvo al estado DS_IDLE
					sender->state = DS_IDLE;
					// Para el próximo envío, tengo 0 Timeouts
					sender->timeout_ctr = 0;
					// Cuento el dato perdido
					sender->data_loss_timeouts_ctr ++;
					// Si llegué a la cantidad máxima de datos perdidos por Timeouts consecutivos
					if( sender->data_loss_timeouts_ctr >= MAX_DATA_LOSS_TIMEOUT ){
						// Disparo la alarma si estaba apagada o si había otra (ahí la pisa)
						if( alarmIsOff(&(sender->alarma)) || getAlarmType(&(sender->alarma)) != TIMEOUT_ALARM_TYPE ){
							fireAlarm( &(sender->alarma), TIMEOUT_ALARM_TYPE );
						}
						// Dejo MAX_DATA_LOSS_TIMEOUT como techo del contador (satura en ese número)
						sender->data_loss_timeouts_ctr = MAX_DATA_LOSS_TIMEOUT;
					}
				}
				// Si no llegué a la cantidad máxima de timeouts por envío
				else{
					// Intento enviar nuevamente, todavía no se perdió el dato
					_sendLoadedSample( sender, flags );
					// Paso a esperar el fin de la transmisión
					sender->state = DS_WAITING_FOR_TX_COMPLETE;
				}
			}
			// Si se recibió respuesta
			if( flags->RxComplete ){
				// Apago el timer
				stopTimer( &(sender->timer) );
				// Bajo el flag de Rx
				flags->RxComplete = 0;
				
				switch( sender->rxBuffer ){
					// ACK recibido
					case ACK_CHAR:
						// Contadores de Timeouts en 0
						sender->timeout_ctr = 0;
						sender->data_loss_timeouts_ctr = 0;
						// Contadores de NAKs en 0
						sender->nak_ctr = 0;
						sender->data_loss_naks_ctr = 0;
						// Contadores de Respuestas Inesperadas en 0
						sender->unex_ans_ctr = 0;
						sender->data_loss_unex_ans_ctr = 0;

						// Todo funcionó correctamente, vuelvo al estado DS_IDLE
						sender->state = DS_IDLE;

						// Apago la alarma
						stopAlarm( &(sender->alarma) );
						break;

					// NAK recibido
					case NAK_CHAR:
						// Cuento el NAK
						sender->nak_ctr ++;
						// Si llegué a la cantidad máxima de NAKs consecutivos por envío
						if( sender->nak_ctr >= MAX_NAKS ){
							// ESTE dato se perdió, vuelvo al estado DS_IDLE
							sender->state = DS_IDLE;
							// Para el próximo envío, tengo 0 NAKs
							sender->nak_ctr = 0;
							// Cuento el dato perdido
							sender->data_loss_naks_ctr ++;
							// Si llegué a la cantidad máxima de datos perdidos por NAKs consecutivos
							if( sender->data_loss_naks_ctr >= MAX_DATA_LOSS_NAK ){
							// Disparo la alarma si estaba apagada o si había otra (ahí la pisa)
							if( alarmIsOff(&(sender->alarma)) || getAlarmType(&(sender->alarma)) != NAK_ALARM_TYPE ){
								fireAlarm( &(sender->alarma), NAK_ALARM_TYPE );
							}
								// Dejo MAX_DATA_LOSS_NAK como techo del contador (satura en ese número)
								sender->data_loss_naks_ctr = MAX_DATA_LOSS_NAK;
							}
						}
						// Si no llegué a la cantidad máxima de NAKs por envío
						else{
							// Intento enviar nuevamente, todavía no se perdió el dato
							_sendLoadedSample( sender, flags );
							// Paso a esperar el fin de la transmisión
							sender->state = DS_WAITING_FOR_TX_COMPLETE;
						}
						break;

					// Respuesta Inesperada recibida
					default:
						// Cuento la Respuesta Inesperada
						sender->unex_ans_ctr ++;
						// Si llegué a la cantidad máxima de Respuestas Inesperadas consecutivas por envío
						if( sender->unex_ans_ctr >= MAX_UNEX_ANS ){
							// ESTE dato se perdió, vuelvo al estado DS_IDLE
							sender->state = DS_IDLE;
							// Para el próximo envío, tengo 0 Respuestas Inesperadas
							sender->unex_ans_ctr = 0;
							// Cuento el dato perdido
							sender->data_loss_unex_ans_ctr ++;
							// Si llegué a la cantidad máxima de datos perdidos por Respuestas Inesperadas consecutivos
							if( sender->data_loss_unex_ans_ctr >= MAX_DATA_LOSS_UNEX_ANS ){
							// Disparo la alarma si estaba apagada o si había otra (ahí la pisa)
							if( alarmIsOff(&(sender->alarma)) || getAlarmType(&(sender->alarma)) != UNEX_ANS_ALARM_TYPE ){
								fireAlarm( &(sender->alarma), UNEX_ANS_ALARM_TYPE );
							}
								// Dejo MAX_DATA_LOSS_UNEX_ANS como techo del contador (satura en ese número)
								sender->data_loss_unex_ans_ctr = MAX_DATA_LOSS_UNEX_ANS;
							}
						}
						// Si no llegué a la cantidad máxima de Respuestas Inesperadas por envío
						else{
							// Intento enviar nuevamente, todavía no se perdió el dato
							_sendLoadedSample( sender, flags );
							// Paso a esperar el fin de la transmisión
							sender->state = DS_WAITING_FOR_TX_COMPLETE;
						}
						break;
				}

			}

			// Chequeo la recepción
			HAL_UART_Receive_IT( sender->uart, &(sender->rxBuffer), 1); 
		break;
		
		default:
			// Por default, seteo estado DS_IDLE
			sender->state = DS_IDLE;
			break;

	}

}

// Chequear estado del enviador de datos
uint8_t dataSenderIsReady( DataSender *sender ){
	return (sender->state == DS_IDLE) ? 1 : 0;
}
// Envíar datos (Funciones NO bloqueante)
void sendSample( DataSender *sender, sample data ){
	// Cargo el dato
	sender->data = data;
	// Fuerzo el envío del dato
	sender->state = DS_SENDING_DATA;
}



// Funciones "privadas"

// Transmito un sample
void _sendLoadedSample( DataSender *sender, DS_UartInterruptionFlags *flags ){
	uint8_t with_info;

	// Habilito el envío de datos
	_enableTransmit();

	// Limpio la recepción (porque pueden quedar respuestas anteriores atrasadas)
	sender->rxBuffer = 0;
	flags->RxComplete = 0;

	// DATA SEL: (0 -> OnlyData, 1 -> Data+Info)
	with_info = HAL_GPIO_ReadPin(PORT_DATA_SEL, PIN_DATA_SEL);

	// Datos de lecturas
	sender->txBuffer[0] = (uint8_t) sender->data.bytes.YZ3.byte;
	sender->txBuffer[1] = (uint8_t) sender->data.bytes.WX3.byte;
	sender->txBuffer[2] = (uint8_t) sender->data.bytes.YZ2.byte;
	sender->txBuffer[3] = (uint8_t) sender->data.bytes.WX2.byte;
	sender->txBuffer[4] = (uint8_t) sender->data.bytes.YZ1.byte;
	sender->txBuffer[5] = (uint8_t) sender->data.bytes.WX1.byte;
	sender->txBuffer[6] = (uint8_t) sender->data.bytes.YZ0.byte;
	sender->txBuffer[7] = (uint8_t) sender->data.bytes.WX0.byte;
	// CRC
	sender->txBuffer[8] = _crc8( sender->txBuffer, DATA_SIZE );

	// Modo DATA + INFO 
	if( with_info ){
		// Info de los contadores
		sender->txBuffer[9]  = (uint8_t) 'T';
		sender->txBuffer[10] = (uint8_t) ('0' + sender->data_loss_timeouts_ctr);
		sender->txBuffer[11] = (uint8_t) ('0' + sender->timeout_ctr);
		sender->txBuffer[12] = (uint8_t) 'N';
		sender->txBuffer[13] = (uint8_t) ('0' + sender->data_loss_naks_ctr);
		sender->txBuffer[14] = (uint8_t) ('0' + sender->nak_ctr);
		sender->txBuffer[15] = (uint8_t) 'U';
		sender->txBuffer[16] = (uint8_t) ('0' + sender->data_loss_unex_ans_ctr);
		sender->txBuffer[17] = (uint8_t) ('0' + sender->unex_ans_ctr);
		// Final de la Unidad de Datos de Protocolo (PDU)
		sender->txBuffer[18] = (uint8_t) CHAR_FINISH_PDU;

		// Envío el buffer
		HAL_UART_Transmit_IT( sender->uart, sender->txBuffer, BUFFER_SIZE_DATA_INFO_MODE);
	}
	// Modo ONLY DATA
	else{
		// Final de la Unidad de Datos de Protocolo (PDU)
		sender->txBuffer[9] = (uint8_t) CHAR_FINISH_PDU;

		// Envío el buffer
		HAL_UART_Transmit_IT( sender->uart, sender->txBuffer, BUFFER_SIZE_ONLY_DATA_MODE);
	}

}

// Control de Envío/Recepción
void _enableReceive( void ){
	HAL_GPIO_WritePin(PORT_EN_TX3, PIN_EN_TX3, GPIO_PIN_RESET);
}
void _enableTransmit( void ){
	HAL_GPIO_WritePin(PORT_EN_TX3, PIN_EN_TX3, GPIO_PIN_SET);
}
// Obtener el byte de crc8 para el chequeo de los datos
uint8_t _crc8( uint8_t *data, uint8_t len){
	uint8_t i;
	uint8_t crc = 0x00;

	//for( i = len-1; i >= 0; i -- ){
	//	crc = crc8_table[ crc ^ data[i] ];
	//}
	for( i = 0; i < len; i ++ ){
		crc = crc8_table[ crc ^ data[i] ];
	}

	return crc;
}


/* _CRC8 IMPLEMENTATION WORKING EXAMPLE FOUND 
uint8_t crc8( uint8_t *data, uint8_t len){
	// CRC para polynomial 0x07 (default polynomial para crc-8)
	uint16_t i;
    uint16_t crc = 0x0;

	while (len--) {
			i = (crc ^ *data++) & 0xFF;
			crc = (crc8_table[i] ^ (crc << 8)) & 0xFF;
	}

	return crc & 0xFF;
}
*/
