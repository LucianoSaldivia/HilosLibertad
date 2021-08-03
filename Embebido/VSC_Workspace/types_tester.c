#include <stdio.h>
#include "types.h"

// Assumes little endian
void printBits( void const * const ptr, size_t const size ){
    unsigned char *b = (unsigned char*) ptr;
    unsigned char byte;
    int i, j;
    
    for (i = size-1; i >= 0; i--) {
        for (j = 7; j >= 0; j--) {
            byte = (b[i] >> j) & 1;
            printf("%u", byte);
        }
        printf(" ");
    }
    printf("\n");
}

void main( void ){  
    sample s;
    
    s.sample = 0;
    s.nibbles.Z1 |= 0x01;
    
    printBits( &s, 8 );
}
