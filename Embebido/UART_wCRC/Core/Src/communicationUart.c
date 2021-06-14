#include "communicationUart.h"
#include "main.h"

void uartEnableReceive( void ){
	HAL_GPIO_WritePin(GPIOB, GPIO_PIN_12, GPIO_PIN_RESET);
}

void uartEnableTransmit( void ){
	HAL_GPIO_WritePin(GPIOB, GPIO_PIN_12, GPIO_PIN_SET);
}

int sizeUntilSlashZero( uint8_t *vec, int size ){
	int contador = 0, i;
	for( i = 0; i < size; i ++ ){
		if( vec[i] != '\0' ){
			contador ++;
		}
		else return contador;
	}
	return contador;
}

void clearAll( uint8_t *vec, int size ){
	int i;
	for( i = 0; i < size; i ++ ){
		if( vec[i] != '\0' ){
			vec[i] = '\0';
		}
		else return;
	}
}

//uint8_t crc8( uint8_t *data, uint8_t len){
//	// CRC para polynomial 0x07 (default polynomial para crc-8)
//	uint16_t i;
//    uint16_t crc = 0x0;
//
//  while (len--) {
//          i = (crc ^ *data++) & 0xFF;
//          crc = (crc8_table[i] ^ (crc << 8)) & 0xFF;
//  }
//
//  return crc & 0xFF;
//}

uint8_t crc8( uint8_t *data, uint8_t len){
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












