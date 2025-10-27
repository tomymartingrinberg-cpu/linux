#!/bin/bash

# Variables
BUILD_DIR="build"
OUTPUT_DIR="output"
ARCHITECTURE="x86_64"

# Crear directorios
mkdir -p $BUILD_DIR
mkdir -p $OUTPUT_DIR

echo "Iniciando la construcción de la imagen para la arquitectura $ARCHITECTURE..."

# Aquí iría el proceso de construcción de la imagen, ejemplo:
# ./build_image --arch $ARCHITECTURE --output $OUTPUT_DIR

echo "Imagen construida en $OUTPUT_DIR"

# Finalizar
echo "Proceso de construcción finalizado."
