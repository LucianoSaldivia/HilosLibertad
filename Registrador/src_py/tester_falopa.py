import SQL_Writer
import config_SQL_Database


def elimina_repetidos(lista: list) -> list:

    unique = []
    [unique.append(item) for item in lista if item not in unique]
    return unique


if __name__ == "__main__":
    
    lista = [*range(0,15,1)]
    lista.append(2)
    lista.append(2)
    lista.append(2)
    lista.append(4)
    lista.append(10)
    lista.insert(5, 2)
    lista.insert(8, 2)
    print(lista)
    print(elimina_repetidos(lista))
