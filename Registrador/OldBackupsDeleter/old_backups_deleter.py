# fileManager.py

import sys
import os
from pathlib import Path


FILES_DIRECTORY = "C:/HLSaldivia/DB/BACKUP_DB_HILOSLIBERTAD/"
FILE_TYPE = ".bak"
NUMBER_OF_FILES_NOT_TO_DELETE = 3


# Funciones listadoras de entradas/archivos
def getEntriesList() -> list:
    return sorted( Path(FILES_DIRECTORY).iterdir(), key=os.path.getmtime )
def getEntriesList_NewestFirst() -> list:
    return sorted( Path(FILES_DIRECTORY).iterdir(), key=os.path.getmtime )[::-1]
def getFilesList(path: str, file_type: str) -> list:
    files = list()
    for file in os.listdir(path):
        if os.path.isfile(os.path.join(path, file)) and (file_type in file):
            files.append( path + file )

    return files
def getFilesList_NewestFirst(path: str, file_type: str) -> list:
    files = list()
    for file in os.listdir(path):
        if os.path.isfile(os.path.join(path, file)) and (file_type in file):
            files.append( path + file )

    return files[::-1]


# Funcion principal
def main(debug: bool):

    # Obtengo los archivos de tipo FILE_TYPE ordenados (últimos modificados primero)
    files_prev = getFilesList_NewestFirst( FILES_DIRECTORY, FILE_TYPE )

    # Borro todos, menos los últimos NUMBER_OF_FILES_NOT_TO_DELETE
    for i in range( len(files_prev) ):
        if i >= NUMBER_OF_FILES_NOT_TO_DELETE:
            os.remove( files_prev[i] )

    # Muestro los deltas
    if debug:
        files_post = [files_prev[i] for i in range(len(files_prev)) if not i >= NUMBER_OF_FILES_NOT_TO_DELETE]

        # print("Initial files:")
        # for file in files_prev:
        #     print(file)

        # print("After deletion:")
        # for file in files_post:
        #     print(file)
        
        print("Deleted files:")
        for file in files_prev: 
            if file not in files_post:
                print(file)
        
        print("Left files:")
        for file in files_prev:
            if file in files_post:
                print(file)

if __name__ == "__main__":
    
    # Carga estandar de argumentos por línea de comandos a una lista
    args = sys.argv[1:]

    # Default (para debuggear)
    if len(args) == 0:
        main(debug=True)
    
    # Debug?
    elif len(args) == 1 and args[0] == "-debug":
        main(debug=True)
    elif len(args) == 1 and args[0] == "-no_debug":
        main(debug=False)
