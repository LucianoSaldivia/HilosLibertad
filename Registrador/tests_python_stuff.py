# test_python_suff.py


import config_boards

def vaciadorDeListas( lista: list ) -> list: 
    lista.clear()
    return lista


if __name__ == "__main__":
    
    todas = list( range(1, 64+ 1 ) )
    
    for item in todas:
        if item in config_boards.CONNECTED_MAQS:
            print( item )


