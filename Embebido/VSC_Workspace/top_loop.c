#include <stdint.h>
#include "main.h"

/* Private includes ----------------------------------------------------------*/
/* USER CODE BEGIN Includes */
#include "alarm.h"
#include "dataSender.h"
#include "debouncer.h"
#include "muxReader.h"
#include "pinConnections.h"
#include "timers.h"
#include "types.h"
/* USER CODE END Includes */

//...

/* USER CODE BEGIN PV */
DS_UartInterruptionFlags uart_flags;
Debouncer_TimerInterruptionFlag TIM_flag;
/* USER CODE END PV */

//...

/* USER CODE BEGIN 0 */
void HAL_UART_TxCpltCallback(UART_HandleTypeDef *huart){
    uart_flags.TxComplete = 1;
}

void HAL_UART_RxCpltCallback(UART_HandleTypeDef *huart){
    uart_flags.RxComplete = 1;
}
void HAL_TIM_PeriodElapsedCallback(TIM_HandleTypeDef *htim){
	TIM_flag.timer_finished = 1;
	HAL_TIM_Base_Stop_IT(htim);
}
/* USER CODE END 0 */




int main( void ){

    /* USER CODE BEGIN 1 */
	MuxReader reader;
	DataSender sender;

	sample new_sample;
	uint8_t already_sent_flag = 0;
  /* USER CODE END 1 */

    //...    

  /* USER CODE BEGIN 2 */
	initMuxReader( &reader, &htim2 );
	initDataSender( &sender, &huart3 );
	initDS_UartInterruptionFlags( &uart_flags );
	initDebouncer_TimerInterruptionFlag( &TIM_flag );
  /* USER CODE END 2 */
    
    //...

    // top loop
    while(1){

        /* USER CODE BEGIN 3 */
		FSM_MuxReader( &reader, &TIM_flag );
		FSM_DataSender( &sender, &uart_flags );

		// Si está listo para ser leído, y no se envió
		int aux_readerIsReady = newSampleReady( &reader );
		if( aux_readerIsReady && already_sent_flag == 0 ){
			// Obtengo la lectura
			new_sample = getSample( &reader );

			// Envío según el modo
			sendSample( &sender, new_sample );
			already_sent_flag = 1;
		}
		// Si no está listo para ser leído
		else if( !aux_readerIsReady ){
			// Renuevo el flag para el próximo envío de lectura
			already_sent_flag = 0;
		}
	}
	/* USER CODE END 3 */
        
}
