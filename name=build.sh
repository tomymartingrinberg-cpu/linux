#!/usr/bin/env bash
set -euo pipefail
# build.sh - Construye la ISO usando live-build
# Ejecutar con: sudo ./build.sh
# Adaptado para Newux

DISTRO_NAME="newux"
DISTRO_VERSION="jammy"   # cambiar por jammy (22.04), lunar (24.04) según repositorio disponible
ARCH="amd64"
LB_DIR="live-build-config"

# Requisitos básicos (no instala automáticamente)
echo "Comprobando requisitos..."
for pkg in live-build squashfs-tools xorriso grub-pc-bin grub-efi-amd64-bin mtools wget debootstrap; do
  if ! dpkg -s "$pkg" &>/dev/null; then
    echo "Falta paquete: $pkg. Instálalo con: sudo apt install $pkg"
    exit 1
  fi
done

# Preparar directorio
rm -rf "${LB_DIR}"
mkdir -p "${LB_DIR}"
cd "${LB_DIR}"

# Configurar live-build
lb config \
  --distribution "${DISTRO_VERSION}" \
  --archive-areas "main restricted universe multiverse" \
  --architectures "${ARCH}" \
  --binary-images iso-hybrid \
  --apt-indices false \
  --bootappend-live "persistent" \
  --debian-installer live \
  --backports false \
  --linux-flavours "generic" \
  --distribution "${DISTRO_VERSION}"

# Copiar listas y hooks si existen en ../
if [ -d ../package-lists ]; then
  mkdir -p config
  cp -r ../package-lists ./config/package-lists || true
fi
if [ -d ../hooks ]; then
  mkdir -p config/hooks
  cp -r ../hooks/* ./config/hooks/ || true
  find config/hooks -type f -exec chmod +x {} \;
fi
if [ -d ../config/includes.chroot ]; then
  mkdir -p config/includes.chroot
  cp -r ../config/includes.chroot/* config/includes.chroot/ || true
fi

echo "Ejecutando lb build (esto puede tardar bastante y descarga paquetes)..."
sudo lb build

# Mover ISO resultante fuera
if [ -f live-image-amd64.hybrid.iso ]; then
  mv live-image-amd64.hybrid.iso ../${DISTRO_NAME}-${DISTRO_VERSION}.iso
  echo "ISO creada: ../${DISTRO_NAME}-${DISTRO_VERSION}.iso"
else
  echo "No se encontró la ISO generada. Revisa la salida de lb build."
fi
