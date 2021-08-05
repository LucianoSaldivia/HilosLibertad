


def vaciadorDeListas( lista: list ) -> list: 
    lista.clear()
    return lista

if __name__ == "__main__":
    a = list()
    a = [*range(7, -1, -1)]
    
    print([*range(1, len(a))])
    print(len(a))
    print(a)
    for i in range(1, len(a)):
        print( a[i] )

    print()
    print()
    print( vaciadorDeListas(a) )





    # a = b"hola"
    # # Debería ser False
    # True if (int.from_bytes(a,"little")>>0 & 0x01) else False
    # # Debería ser False
    # True if (int.from_bytes(a,"little")>>1 & 0x01) else False
    # # Debería ser False
    # True if (int.from_bytes(a,"little")>>2 & 0x01) else False
    # # Debería ser True
    # True if (int.from_bytes(a,"little")>>3 & 0x01) else False