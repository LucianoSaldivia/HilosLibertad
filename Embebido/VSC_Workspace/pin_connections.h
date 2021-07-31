#ifndef _PIN_CONNECTIONS_H_
#define	_PIN_CONNECTIONS_H_

    /* MUXED INPUTS */
    #ifndef _GROUP_INPUTS_WXYZ_
    #define _GROUP_INPUTS_WXYZ_
        
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
        #define PORT_W1     GPIOA
        #define PIN_W1      GPIO_PIN_12
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

    #endif

    /* MUX CONTROL - OUTPUTS */
    #ifndef _GROUP_MUX_CONTROL_OUTPUTS_AB_
    #define _GROUP_MUX_CONTROL_OUTPUTS_AB_
        
        // Outputs (~A, ~B)
        #define PORT_A      GPIOB
        #define PIN_A       GPIO_PIN_0
        #define PORT_B      GPIOA
        #define PIN_B       GPIO_PIN_7

    #endif

    /* BUZZER / BEEPER - OUTPUT */
    #define PORT_BUZZER     GPIOB
    #define PIN_BUZZER      GPIO_PIN_9

    /* DATA TO SEND CONTROL - INPUT */
    #define PORT_DATA_SEL   GPIOA
    #define PIN_DATA_SEL    GPIO_PIN_0

    /* UART - INPUTS/OUTPUTS */
    #ifndef _GROUP_UART_
    #define _GROUP_UART_
        
        // Outputs (RX3, TX3, ENR)
        #define PORT_RX3    GPIOB
        #define PIN_RX3     GPIO_PIN_11
        #define PORT_TX3    GPIOB
        #define PIN_TX3     GPIO_PIN_10
        #define PORT_EN_T   GPIOB
        #define PIN_EN_T    GPIO_PIN_1

    #endif


#endif
