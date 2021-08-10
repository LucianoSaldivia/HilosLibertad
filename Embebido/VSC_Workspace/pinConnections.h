#ifndef _PIN_CONNECTIONS_H_
#define	_PIN_CONNECTIONS_H_

    /* Placas conectadas */
    #define BOARD0
    #define BOARD1
    #define BOARD2
    #define BOARD3

    #if defined(BOARD0) && defined(BOARD1) && defined(BOARD2) && defined(BOARD3)
        #define ALL_4_BOARDS
    #endif /* BOARD0 && BOARD1 && BOARD2 && BOARD3 */
    #if defined(BOARD0) || defined(BOARD1) || defined(BOARD2) || defined(BOARD3)
        #define AT_LEAST_ONE_BOARD
    #endif /* BOARD0 || BOARD1 || BOARD2 || BOARD3 */

    /* GPIOS LIBRES */
    #ifndef _GROUP_FREE_
    #define _GROUP_FREE_
        #define PORT_FREE_1     GPIOA
        #define PIN_FREE_1      GPIO_PIN_1
        #define PORT_FREE_2     GPIOA
        #define PIN_FREE_2      GPIO_PIN_2
        #define PORT_FREE_3     GPIOA
        #define PIN_FREE_3      GPIO_PIN_3
        #define PORT_FREE_4     GPIOA
        #define PIN_FREE_4      GPIO_PIN_4
        #define PORT_FREE_5     GPIOA
        #define PIN_FREE_5      GPIO_PIN_5
        #define PORT_FREE_6     GPIOA
        #define PIN_FREE_6      GPIO_PIN_6
    #endif /* _GROUP_FREE_ */

    /* MUXED INPUTS */
    #ifndef _GROUP_INPUTS_WXYZ_
    #define _GROUP_INPUTS_WXYZ_
	// DEBEN SER (No Pull-Up and No Pull-Down)
        // Inputs 0 (W0, X0, Y0, Z0)
        #define PORT_W0     GPIOB
        #define PIN_W0      GPIO_PIN_5
        #define PORT_X0     GPIOB
        #define PIN_X0      GPIO_PIN_6
        #define PORT_Y0     GPIOB
        #define PIN_Y0      GPIO_PIN_7
        #define PORT_Z0     GPIOB
        #define PIN_Z0      GPIO_PIN_8     
        // Inputs 1 (W1, X1, Y1, Z1)
            // W1 originalmente era A12, quemado y cambiado por A1
        #define PORT_W1     PORT_FREE_1/* GPIOA */
        #define PIN_W1      PIN_FREE_1/* GPIO_PIN_12 */
        #define PORT_X1     GPIOA
        #define PIN_X1      GPIO_PIN_15
        #define PORT_Y1     GPIOB
        #define PIN_Y1      GPIO_PIN_3
        #define PORT_Z1     GPIOB
        #define PIN_Z1      GPIO_PIN_4
        // Inputs 2 (W2, X2, Y2, Z2)
        #define PORT_W2     GPIOA
        #define PIN_W2      GPIO_PIN_8
        #define PORT_X2     GPIOA
        #define PIN_X2      GPIO_PIN_9
        #define PORT_Y2     GPIOA
        #define PIN_Y2      GPIO_PIN_10
        #define PORT_Z2     GPIOA
        #define PIN_Z2      GPIO_PIN_11
        // Inputs 3 (W3, X3, Y3, Z3)
        #define PORT_W3     GPIOB
        #define PIN_W3      GPIO_PIN_15
        #define PORT_X3     GPIOB
        #define PIN_X3      GPIO_PIN_14
        #define PORT_Y3     GPIOB
        #define PIN_Y3      GPIO_PIN_13
        #define PORT_Z3     GPIOB
        #define PIN_Z3      GPIO_PIN_12
    #endif /* _GROUP_INPUTS_WXYZ_ */

    /* MUX CONTROL - OUTPUTS */
    #ifndef _GROUP_MUX_CONTROL_OUTPUTS_AB_
    #define _GROUP_MUX_CONTROL_OUTPUTS_AB_       
        // Outputs (~A, ~B)
        #define PORT_A      GPIOB
        #define PIN_A       GPIO_PIN_0
        #define PORT_B      GPIOA
        #define PIN_B       GPIO_PIN_7
    #endif /* _GROUP_MUX_CONTROL_OUTPUTS_AB_ */

    /* BUZZER / BEEPER - OUTPUT */
    #define PORT_BUZZER     GPIOB
    #define PIN_BUZZER      GPIO_PIN_9

    /* DATA TO SEND CONTROL - INPUT */
    // (0 -> OnlyData, 1 -> Data+Info - Debe ser PULL-UP)
    #define PORT_DATA_SEL   GPIOA
    #define PIN_DATA_SEL    GPIO_PIN_0

    /* UART - INPUTS/OUTPUTS */
    #ifndef _GROUP_UART_
    #define _GROUP_UART_       
        // UART3 (RX3, TX3)
        #define PORT_RX3    GPIOB
        #define PIN_RX3     GPIO_PIN_11
        #define PORT_TX3    GPIOB
        #define PIN_TX3     GPIO_PIN_10
        // Enable Tx (Output)
        #define PORT_EN_TX3 GPIOB
        #define PIN_EN_TX3  GPIO_PIN_1
    #endif /* _GROUP_UART_ */

    /* LED Testigo */
    #define PORT_OB_LED     GPIOC
    #define PIN_OB_LED      GPIO_PIN_13


#endif /* _PIN_CONNECTIONS_H_ */
