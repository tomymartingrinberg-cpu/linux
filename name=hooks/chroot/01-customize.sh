#!/bin/sh
set -e
# Este script se ejecuta dentro del chroot durante la construcción
# Personalizaciones: crear usuario, configurar hostname, instalar SSH keys, etc.

# Cambia el nombre del host
echo "newux" > /etc/hostname

# Crear usuario por defecto (usuario: newux) y añadir a sudo
if ! id -u newux >/dev/null 2>&1; then
  useradd -m -s /bin/bash newux || true
  echo "newux:changeme" | chpasswd
  usermod -aG sudo newux
fi

# Configuración mínima de locales (opcional)
if command -v locale-gen >/dev/null 2>&1; then
  locale-gen es_ES.UTF-8 || true
  update-locale LANG=es_ES.UTF-8 || true
fi

# Limpiar cache de apt
apt-get clean
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Añadir mensaje de bienvenida en /etc/motd
cat >/etc/motd <<'MOTD'
Bienvenido a Newux (basada en Ubuntu)
MOTD
