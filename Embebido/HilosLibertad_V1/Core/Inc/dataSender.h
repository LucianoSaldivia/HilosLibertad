#ifndef _DATA_SENDER_H_
#define _DATA_SENDER_H_

    #include "main.h"
    #include "pinConnections.h"
    #include "alarm.h"
    #include "timers.h"


    // Tiempo de Timeout
    #define TIMEOUT_TIME            ((uint32_t) (100 * MILISEG))	/* (200 * MILISEG) */
    // Timeouts                 (+ probable)
    #define MAX_TIMEOUTS            (uint8_t) 5
    #define MAX_DATA_LOSS_TIMEOUT   (uint8_t) 5
    #define TIMEOUT_ALARM_TYPE      (AlarmType) QUADRUPLE_BEEP
    // NAKs                     (- probable)
    #define MAX_NAKS                (uint8_t) 5
    #define MAX_DATA_LOSS_NAK       (uint8_t) 5
    #define NAK_ALARM_TYPE          (AlarmType) TRIPLE_BEEP
    // Respuestas Inesperadas   (casi imposible)
    #define MAX_UNEX_ANS            (uint8_t) 5
    #define MAX_DATA_LOSS_UNEX_ANS  (uint8_t) 5
    #define UNEX_ANS_ALARM_TYPE     (AlarmType) DOUBLE_BEEP

    // Caracteres ACK y NAK
    #define ACK_CHAR                (uint8_t) '%'
    #define NAK_CHAR                (uint8_t) '?'
    // Tramas y tamaños
    /*  Trama completa Modo: ONLY DATA, byte a byte:
        01: W0X0 
        02: Y0Z0 
        03: W1X1 
        04: Y1Z1 
        05: W2X2 
        06: Y2Z2 
        07: W3X3 
        08: Y3Z3 
        09: CRC_datos (01 a 08)
        10: CHAR_FINISH_PDU
    */
    /*  Trama completa Modo: DATA INFO, byte a byte:
        01: W0X0 
        02: Y0Z0 
        03: W1X1 
        04: Y1Z1 
        05: W2X2 
        06: Y2Z2 
        07: W3X3 
        08: Y3Z3 
        09: CRC_datos (01 a 08)
        10: T - Timeouts
        11: (uint8_t) timeout_ctr + '0'
        12: (uint8_t) data_loss_timeouts_ctr + '0'
        13: N - NAKs
        14: (uint8_t) nak_ctr + '0'
        15: (uint8_t) data_loss_naks_ctr + '0'
        16: U - Unexpected answers
        17: (uint8_t) unex_ans_ctr + '0'
        18: (uint8_t) data_loss_unex_ans_ctr + '0' 
        19: CHAR_FINISH_PDU
    */
    #define CHAR_FINISH_PDU             '#'
    #define DATA_SIZE                   8
    #define INFO_SIZE                   9
    #define BUFFER_SIZE_ONLY_DATA_MODE  (uint16_t) 10
    #define BUFFER_SIZE_DATA_INFO_MODE  (uint16_t) 19
    #define MAX_BUFFER_SIZE             BUFFER_SIZE_DATA_INFO_MODE


    static const uint8_t crc8_table[] = {
        0x00, 0x07, 0x0e, 0x09, 0x1c, 0x1b, 0x12, 0x15, 0x38, 0x3f, 0x36, 0x31,
        0x24, 0x23, 0x2a, 0x2d, 0x70, 0x77, 0x7e, 0x79, 0x6c, 0x6b, 0x62, 0x65,
        0x48, 0x4f, 0x46, 0x41, 0x54, 0x53, 0x5a, 0x5d, 0xe0, 0xe7, 0xee, 0xe9,
        0xfc, 0xfb, 0xf2, 0xf5, 0xd8, 0xdf, 0xd6, 0xd1, 0xc4, 0xc3, 0xca, 0xcd,
        0x90, 0x97, 0x9e, 0x99, 0x8c, 0x8b, 0x82, 0x85, 0xa8, 0xaf, 0xa6, 0xa1,
        0xb4, 0xb3, 0xba, 0xbd, 0xc7, 0xc0, 0xc9, 0xce, 0xdb, 0xdc, 0xd5, 0xd2,
        0xff, 0xf8, 0xf1, 0xf6, 0xe3, 0xe4, 0xed, 0xea, 0xb7, 0xb0, 0xb9, 0xbe,
        0xab, 0xac, 0xa5, 0xa2, 0x8f, 0x88, 0x81, 0x86, 0x93, 0x94, 0x9d, 0x9a,
        0x27, 0x20, 0x29, 0x2e, 0x3b, 0x3c, 0x35, 0x32, 0x1f, 0x18, 0x11, 0x16,
        0x03, 0x04, 0x0d, 0x0a, 0x57, 0x50, 0x59, 0x5e, 0x4b, 0x4c, 0x45, 0x42,
        0x6f, 0x68, 0x61, 0x66, 0x73, 0x74, 0x7d, 0x7a, 0x89, 0x8e, 0x87, 0x80,
        0x95, 0x92, 0x9b, 0x9c, 0xb1, 0xb6, 0xbf, 0xb8, 0xad, 0xaa, 0xa3, 0xa4,
        0xf9, 0xfe, 0xf7, 0xf0, 0xe5, 0xe2, 0xeb, 0xec, 0xc1, 0xc6, 0xcf, 0xc8,
        0xdd, 0xda, 0xd3, 0xd4, 0x69, 0x6e, 0x67, 0x60, 0x75, 0x72, 0x7b, 0x7c,
        0x51, 0x56, 0x5f, 0x58, 0x4d, 0x4a, 0x43, 0x44, 0x19, 0x1e, 0x17, 0x10,
        0x05, 0x02, 0x0b, 0x0c, 0x21, 0x26, 0x2f, 0x28, 0x3d, 0x3a, 0x33, 0x34,
        0x4e, 0x49, 0x40, 0x47, 0x52, 0x55, 0x5c, 0x5b, 0x76, 0x71, 0x78, 0x7f,
        0x6a, 0x6d, 0x64, 0x63, 0x3e, 0x39, 0x30, 0x37, 0x22, 0x25, 0x2c, 0x2b,
        0x06, 0x01, 0x08, 0x0f, 0x1a, 0x1d, 0x14, 0x13, 0xae, 0xa9, 0xa0, 0xa7,
        0xb2, 0xb5, 0xbc, 0xbb, 0x96, 0x91, 0x98, 0x9f, 0x8a, 0x8d, 0x84, 0x83,
        0xde, 0xd9, 0xd0, 0xd7, 0xc2, 0xc5, 0xcc, 0xcb, 0xe6, 0xe1, 0xe8, 0xef,
        0xfa, 0xfd, 0xf4, 0xf3
    };


    typedef struct DS_UartInterruptionFlags{
        uint8_t TxComplete;
        uint8_t RxComplete;
    } DS_UartInterruptionFlags;

    typedef enum DataSenderState{
        DS_IDLE,
        DS_SENDING_DATA,
        DS_WAITING_FOR_TX_COMPLETE,
        DS_WAITING_ANSWER
    } DataSenderState;

    typedef struct DataSender{
        DataSenderState state;
        UART_HandleTypeDef *uart;
        
        uint8_t timeout_ctr;
        uint8_t data_loss_timeouts_ctr;
        uint8_t nak_ctr;
        uint8_t data_loss_naks_ctr;
        uint8_t unex_ans_ctr;
        uint8_t data_loss_unex_ans_ctr;
        
        sample data;
        uint8_t txBuffer[MAX_BUFFER_SIZE];
        uint8_t rxBuffer;

        Alarm alarma;
        Timer timer;
    } DataSender;


    // Inicializar la estructura de flags de interrupciones
    void initDS_UartInterruptionFlags( DS_UartInterruptionFlags *flags );
    // Inicializar el enviador de datos
    void initDataSender( DataSender *sender, UART_HandleTypeDef *uart );
    
    // FSM del enviador de datos
    void FSM_DataSender( DataSender *sender, DS_UartInterruptionFlags *flags );

    // Chequear estado del enviador de datos
    uint8_t dataSenderIsReady( DataSender *sender );
    // Envíar datos (Funcion NO bloqueante)
    void sendSample( DataSender *sender, sample data );

    
    // Funciones "privadas"
    
    // Transmito un sample
    void _sendLoadedSample( DataSender *sender, DS_UartInterruptionFlags *flags );
    // Control de Envío/Recepción
    void _enableReceive( void );
    void _enableTransmit( void );
    // Obtener el byte de crc8 para el chequeo de los datos
    uint8_t _crc8( uint8_t *data, uint8_t len);


    /*  Uso ejemplo:

    DS_UartInterruptionFlags uart_flags;

    void HAL_UART_TxCpltCallback(UART_HandleTypeDef *huart){
        uart_flags.TxComplete = 1;
    }

    void HAL_UART_RxCpltCallback(UART_HandleTypeDef *huart){
        uart_flags.RxComplete = 1;
    }

    ...
    
    main(){
        DataSender sender;
        sample new_sample;

        ...

        initUartInterruptionFlags( &flags );
        initDataSender( &sender, &huart3 );

        ...

        while(1){

            ...

            FSM_DataSender( &sender, flags );

            ...

            if( dataSenderIsReady( &sender ) ){
                sendSample( &sender, new_sample );
            }

            ...
        }
    }
    
    */

#endif /* _DATA_SENDER_H_ */
