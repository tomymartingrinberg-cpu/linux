#!/bin/bash

# Variables
ARTIFACTS_DIR="output"
REMOTE_SERVER="user@remote-server:/path/to/upload"
LOG_FILE="upload.log"

# Subir artefactos
echo "Subiendo artefactos al servidor remoto..."

scp $ARTIFACTS_DIR/* $REMOTE_SERVER > $LOG_FILE 2>&1

if [ $? -eq 0 ]; then
    echo "Artefactos subidos correctamente."
else
    echo "Error en la carga de artefactos."
    tail -n 20 $LOG_FILE
fi
