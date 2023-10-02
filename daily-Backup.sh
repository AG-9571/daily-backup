#!/bin/bash
# Autor: Angel Ortega - ag9571
# Date: 02/10/2022
# Version: 1.0

DIR="app"
BACKUP_DIR="./backups"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
ARCHIVO="$BACKUP_DIR/backup_$TIMESTAMP.tar.gz"

# Crea el directorio de backups si no existe
mkdir -p $BACKUP_DIR

# Crea el backup comprimido
tar -czf $ARCHIVO $DIR

# Confirma que se ha creado el backup
if [ $? -eq 0 ]; then
    echo "Backup creado con éxito en: $ARCHIVO"
else
    echo "Error al crear el backup."
    exit 1
fi

# Comprueba si el mes de los backups es diferente al actual y añadelos a una carpeta interna del mismo directorio de backups
if [ $(date +%m) != $(date -r $ARCHIVO +%m) ]; then
    mkdir -p $BACKUP_DIR/$(date +%Y)
    mv $ARCHIVO $BACKUP_DIR/$(date +%Y)
fi
