#!/bin/bash

# Personalización del entorno chroot
echo "Ejecutando personalizaciones en el entorno chroot..."

# Crear un archivo de configuración de ejemplo
echo "Mi configuración personalizada" > /etc/my_config.txt

# Instalar algunos paquetes adicionales
apt-get install -y vim

echo "Personalización del chroot completada."
