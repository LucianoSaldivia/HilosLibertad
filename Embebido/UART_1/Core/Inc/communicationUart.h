/*
 * communicationUart.h
 *
 *  Created on: Jun 12, 2021
 *      Author: saldi
 */

#ifndef INC_COMMUNICATIONUART_H_
#define INC_COMMUNICATIONUART_H_

#include "main.h"

void uartEnableReceive( void );
void uartEnableTransmit( void );
int sizeUntilSlashZero( uint8_t *vec, int size );
void clearAll( uint8_t *vec, int size );

#endif /* INC_COMMUNICATIONUART_H_ */
