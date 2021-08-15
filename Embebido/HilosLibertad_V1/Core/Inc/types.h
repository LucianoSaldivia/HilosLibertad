#ifndef _SAMPLE_TYPES_H_
#define _SAMPLE_TYPES_H_
    
    #include "main.h"
   	// define para NULL
    #include <stddef.h>


	#define MILISEG                         ((int) 1)
    #define SEG                             ((int) 1000 * MILISEG)
    #define MIN                             ((int) 60 * SEG)


    // struct byte (como bits o nibbles)
    typedef struct byte_bits{
        uint8_t bit0 : 1;
        uint8_t bit1 : 1;
        uint8_t bit2 : 1;
        uint8_t bit3 : 1;
        uint8_t bit4 : 1;
        uint8_t bit5 : 1;
        uint8_t bit6 : 1;
        uint8_t bit7 : 1;
    } byte_bits;
    typedef struct byte_nibbles{
        uint8_t nbl : 4;
        uint8_t nbh : 4;
    } byte_nibbles;
    // union byte -> byte / byte_nibbles / byte_bits
    typedef union byte{
        uint8_t byte;
        byte_nibbles nibbles;
        byte_bits bits;
    } byte;

    // struct board (como bits, nibbles o bytes)
    typedef struct board_bits{
        uint8_t bit00 : 1;
        uint8_t bit01 : 1;
        uint8_t bit02 : 1;
        uint8_t bit03 : 1;
        uint8_t bit04 : 1;
        uint8_t bit05 : 1;
        uint8_t bit06 : 1;
        uint8_t bit07 : 1;
        uint8_t bit08 : 1;
        uint8_t bit09 : 1;
        uint8_t bit10 : 1;
        uint8_t bit11 : 1;
        uint8_t bit12 : 1;
        uint8_t bit13 : 1;
        uint8_t bit14 : 1;
        uint8_t bit15 : 1;
    } board_bits;
    typedef struct board_nibbles{
        uint8_t W : 4;
        uint8_t X : 4;
        uint8_t Y : 4;
        uint8_t Z : 4;
    } board_nibbles;
    typedef struct board_bytes{
        byte WX;
        byte YZ;
    } board_bytes;
    // union board -> board / board_bytes / board_nibbles / board_bits
    typedef union board{
        uint16_t board;
        board_bytes bytes;
        board_nibbles nibbles;
        board_bits bits;
    } board;
    
    // struct sample (como bits, nibbles, bytes o boards)
    typedef struct sample_bits{
        uint8_t bit00 : 1;
        uint8_t bit01 : 1;
        uint8_t bit02 : 1;
        uint8_t bit03 : 1;
        uint8_t bit04 : 1;
        uint8_t bit05 : 1;
        uint8_t bit06 : 1;
        uint8_t bit07 : 1;
        uint8_t bit08 : 1;
        uint8_t bit09 : 1;
        uint8_t bit10 : 1;
        uint8_t bit11 : 1;
        uint8_t bit12 : 1;
        uint8_t bit13 : 1;
        uint8_t bit14 : 1;
        uint8_t bit15 : 1;
        uint8_t bit16 : 1;
        uint8_t bit17 : 1;
        uint8_t bit18 : 1;
        uint8_t bit19 : 1;
        uint8_t bit20 : 1;
        uint8_t bit21 : 1;
        uint8_t bit22 : 1;
        uint8_t bit23 : 1;
        uint8_t bit24 : 1;
        uint8_t bit25 : 1;
        uint8_t bit26 : 1;
        uint8_t bit27 : 1;
        uint8_t bit28 : 1;
        uint8_t bit29 : 1;
        uint8_t bit30 : 1;
        uint8_t bit31 : 1;
        uint8_t bit32 : 1;
        uint8_t bit33 : 1;
        uint8_t bit34 : 1;
        uint8_t bit35 : 1;
        uint8_t bit36 : 1;
        uint8_t bit37 : 1;
        uint8_t bit38 : 1;
        uint8_t bit39 : 1;
        uint8_t bit40 : 1;
        uint8_t bit41 : 1;
        uint8_t bit42 : 1;
        uint8_t bit43 : 1;
        uint8_t bit44 : 1;
        uint8_t bit45 : 1;
        uint8_t bit46 : 1;
        uint8_t bit47 : 1;
        uint8_t bit48 : 1;
        uint8_t bit49 : 1;
        uint8_t bit50 : 1;
        uint8_t bit51 : 1;
        uint8_t bit52 : 1;
        uint8_t bit53 : 1;
        uint8_t bit54 : 1;
        uint8_t bit55 : 1;
        uint8_t bit56 : 1;
        uint8_t bit57 : 1;
        uint8_t bit58 : 1;
        uint8_t bit59 : 1;
        uint8_t bit60 : 1;
        uint8_t bit61 : 1;
        uint8_t bit62 : 1;
        uint8_t bit63 : 1;
    } sample_bits;
    typedef struct sample_nibbles{
        uint8_t W0 : 4;
        uint8_t X0 : 4;
        uint8_t Y0 : 4;
        uint8_t Z0 : 4;
        uint8_t W1 : 4;
        uint8_t X1 : 4;
        uint8_t Y1 : 4;
        uint8_t Z1 : 4;
        uint8_t W2 : 4;
        uint8_t X2 : 4;
        uint8_t Y2 : 4;
        uint8_t Z2 : 4;
        uint8_t W3 : 4;
        uint8_t X3 : 4;
        uint8_t Y3 : 4;
        uint8_t Z3 : 4;
    } sample_nibbles;
    typedef struct sample_bytes{
        byte WX0;
        byte YZ0;
        byte WX1;
        byte YZ1;
        byte WX2;
        byte YZ2;
        byte WX3;
        byte YZ3;
    } sample_bytes;
    typedef struct sample_boards{
        board board0;
        board board1;
        board board2;
        board board3;
    } sample_boards;
    // union sample -> sample / sample_boards / sample_bytes / sample_nibbles / sample_bits
    typedef union sample{
        uint64_t sample;
        sample_boards boards;
        sample_bytes bytes;
        sample_nibbles nibbles;
        sample_bits bits;
    } sample;
    
#endif /* _SAMPLE_TYPES_H_ */
