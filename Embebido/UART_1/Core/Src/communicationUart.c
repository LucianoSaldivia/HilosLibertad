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
