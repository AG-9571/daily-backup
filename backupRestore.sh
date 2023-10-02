#!/bin/bash
# Description: Script of recovery of the backup
# Autor: Angel Ortega - ag9571
# Date: 02/10/2022
# Version: 1.0

#!/bin/bash

# Verifica que se haya proporcionado la fecha como argumento
if [ "$#" -ne 2 ]; then
    echo "Uso: $0 <fecha_AAAAmmdd> <directorio_destino>"
    exit 1
fi

FECHA="$1"
DIR_DESTINO="$2"
BACKUP_DIR="./backups"
ARCHIVOS_BACKUP=($(ls $BACKUP_DIR/backup_$FECHA*.tar.gz 2> /dev/null))

# Verifica si se encontraron archivos de backup
if [ ${#ARCHIVOS_BACKUP[@]} -eq 0 ]; then
    echo "No se encontró un backup con esa fecha."
    exit 1
fi

# Si hay más de un backup en esa fecha, permite al usuario elegir cuál restaurar
if [ ${#ARCHIVOS_BACKUP[@]} -gt 1 ]; then
    echo "Se encontraron múltiples backups para esa fecha:"
    for i in "${!ARCHIVOS_BACKUP[@]}"; do
        echo "[$i] ${ARCHIVOS_BACKUP[$i]}"
    done
    read -p "Introduce el número del backup que deseas restaurar: " indice
    ARCHIVO_BACKUP=${ARCHIVOS_BACKUP[$indice]}
else
    ARCHIVO_BACKUP=${ARCHIVOS_BACKUP[0]}
fi

# Extrae el contenido del archivo de backup al directorio destino
tar -xzf $ARCHIVO_BACKUP -C $DIR_DESTINO

# Confirma que se ha restaurado el backup
if [ $? -eq 0 ]; then
    echo "Backup restaurado con éxito en: $DIR_DESTINO"
else
    echo "Error al restaurar el backup."
    exit 1
fi



