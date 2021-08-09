


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

    # def bytes_frombitstring(s: str):
    #     return int(s, 2).to_bytes(len(s) // 8, byteorder='big')

    # # last_raw_sample = bytes.fromhex( "0000" + "0000" + "0000" + "0001" )
    # last_raw_sample = bytes_frombitstring( "00000000" + "00000000" + "00000000" + "00000000" + "00000000" + "00000000" + "00000000" + "00000001" )
    # curr_raw_sample = bytes_frombitstring( "00000000" + "00000000" + "00000000" + "00000000" + "00000000" + "00000000" + "00000000" + "00000001" )

    # last_sample = Sesiones.getSamplesFromFrame( last_raw_sample, datetime.now() )  
    # curr_sample = Sesiones.getSamplesFromFrame( curr_raw_sample, datetime.now() )

    # print( last_sample[0] )
    # print( last_sample[1:len(last_sample)] )
    # print( curr_sample[0] )
    # print( curr_sample[1:len(curr_sample)] )

    # new_reports = Sesiones.getReportList( last_sample, curr_sample )

