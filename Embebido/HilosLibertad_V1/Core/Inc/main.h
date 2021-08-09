/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file           : main.h
  * @brief          : Header for main.c file.
  *                   This file contains the common defines of the application.
  ******************************************************************************
  * @attention
  *
  * <h2><center>&copy; Copyright (c) 2021 STMicroelectronics.
  * All rights reserved.</center></h2>
  *
  * This software component is licensed by ST under BSD 3-Clause license,
  * the "License"; You may not use this file except in compliance with the
  * License. You may obtain a copy of the License at:
  *                        opensource.org/licenses/BSD-3-Clause
  *
  ******************************************************************************
  */
/* USER CODE END Header */

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __MAIN_H
#define __MAIN_H

#ifdef __cplusplus
extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/
#include "stm32f1xx_hal.h"

/* Private includes ----------------------------------------------------------*/
/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* Exported types ------------------------------------------------------------*/
/* USER CODE BEGIN ET */

/* USER CODE END ET */

/* Exported constants --------------------------------------------------------*/
/* USER CODE BEGIN EC */

/* USER CODE END EC */

/* Exported macro ------------------------------------------------------------*/
/* USER CODE BEGIN EM */

/* USER CODE END EM */

/* Exported functions prototypes ---------------------------------------------*/
void Error_Handler(void);

/* USER CODE BEGIN EFP */

/* USER CODE END EFP */

/* Private defines -----------------------------------------------------------*/
#define on_board_LED_Pin GPIO_PIN_13
#define on_board_LED_GPIO_Port GPIOC
#define data_sel_Pin GPIO_PIN_0
#define data_sel_GPIO_Port GPIOA
#define W1_Pin GPIO_PIN_1
#define W1_GPIO_Port GPIOA
#define _B_Pin GPIO_PIN_7
#define _B_GPIO_Port GPIOA
#define _A_Pin GPIO_PIN_0
#define _A_GPIO_Port GPIOB
#define enable_tx_Pin GPIO_PIN_1
#define enable_tx_GPIO_Port GPIOB
#define Z3_Pin GPIO_PIN_12
#define Z3_GPIO_Port GPIOB
#define Y3_Pin GPIO_PIN_13
#define Y3_GPIO_Port GPIOB
#define X3_Pin GPIO_PIN_14
#define X3_GPIO_Port GPIOB
#define W3_Pin GPIO_PIN_15
#define W3_GPIO_Port GPIOB
#define W2_Pin GPIO_PIN_8
#define W2_GPIO_Port GPIOA
#define X2_Pin GPIO_PIN_9
#define X2_GPIO_Port GPIOA
#define Y2_Pin GPIO_PIN_10
#define Y2_GPIO_Port GPIOA
#define Z2_Pin GPIO_PIN_11
#define Z2_GPIO_Port GPIOA
#define prev_W1_Pin GPIO_PIN_12
#define prev_W1_GPIO_Port GPIOA
#define X1_Pin GPIO_PIN_15
#define X1_GPIO_Port GPIOA
#define Y1_Pin GPIO_PIN_3
#define Y1_GPIO_Port GPIOB
#define Z1_Pin GPIO_PIN_4
#define Z1_GPIO_Port GPIOB
#define W0_Pin GPIO_PIN_5
#define W0_GPIO_Port GPIOB
#define X0_Pin GPIO_PIN_6
#define X0_GPIO_Port GPIOB
#define Y0_Pin GPIO_PIN_7
#define Y0_GPIO_Port GPIOB
#define Z0_Pin GPIO_PIN_8
#define Z0_GPIO_Port GPIOB
#define Beeper_Pin GPIO_PIN_9
#define Beeper_GPIO_Port GPIOB
/* USER CODE BEGIN Private defines */

/* USER CODE END Private defines */

#ifdef __cplusplus
}
#endif

#endif /* __MAIN_H */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
