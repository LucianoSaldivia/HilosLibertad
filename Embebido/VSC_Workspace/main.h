#include <stdint.h>

/*

Archivo DUMMY para evitar error al incluir "main.h"

*/
#define GPIO_PIN_RESET  0
#define GPIO_PIN_SET    1

#define GPIOA           'A'
#define GPIOB           'B'
#define GPIOC           'C'
#define GPIOD           'D'

#define GPIO_PIN_0      0       
#define GPIO_PIN_1      1   
#define GPIO_PIN_2      2
#define GPIO_PIN_3      3
#define GPIO_PIN_4      4
#define GPIO_PIN_5      5   
#define GPIO_PIN_6      6
#define GPIO_PIN_7      7
#define GPIO_PIN_8      8
#define GPIO_PIN_9      9
#define GPIO_PIN_10     10
#define GPIO_PIN_11     11  
#define GPIO_PIN_12     12      
#define GPIO_PIN_13     13
#define GPIO_PIN_14     14 
#define GPIO_PIN_15     15

typedef struct UART_HandleTypeDef{
    uint8_t dummy;
    uint8_t Instance;
} UART_HandleTypeDef;

static UART_HandleTypeDef huart3;

void HAL_GPIO_WritePin( char dummy_port, uint8_t dummy_uint8_pin, uint8_t dummy_uint8_state );
uint8_t HAL_GPIO_ReadPin( char dummy_port, uint8_t dummy_uint8_pin );

HAL_UART_Receive_IT( UART_HandleTypeDef *uart, uint8_t *buffer, uint16_t size); 
HAL_UART_Transmit_IT( UART_HandleTypeDef *uart, uint8_t *buffer, uint16_t size);