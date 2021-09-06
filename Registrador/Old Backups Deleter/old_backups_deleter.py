# fileManager.py

import os
from pathlib import Path


FILES_DIRECTORY = "E:/Luciano/BACKUP_DB_HILOSLIBERTAD/"
FILE_TYPE = ".bak"
NUMBER_OF_FILES_NOT_TO_DELETE = 5



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

def main():

    # Obtengo los archivos de tipo FILE_TYPE ordenados (últimos modificados primero)
    files = getFilesList_NewestFirst( FILES_DIRECTORY, FILE_TYPE )
    print("Initial files:")
    for file in files:
        print(file)

    # Borro todos, menos los últimos NUMBER_OF_FILES_NOT_TO_DELETE
    for i in range( len(files) ):
        if i >= NUMBER_OF_FILES_NOT_TO_DELETE:
            os.remove( files[i] )

    # Obtengo los archivos de tipo FILE_TYPE ordenados (últimos modificados primero)
    files = getFilesList_NewestFirst( FILES_DIRECTORY, FILE_TYPE )
    print("After deletion:")
    for file in files:
        print(file)


if __name__ == "__main__":
    main()