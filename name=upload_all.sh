#!/usr/bin/env bash
set -euo pipefail
# upload_all.sh - Script simple para añadir, commitear y pushear todos los archivos al remoto "origin"
# Uso: ./upload_all.sh "Mensaje de commit"
# Requiere que el repo ya tenga un remoto "origin" apuntando a GitHub y que la rama principal sea "main".

MSG="${1:-"Update repository"}"
BRANCH="${2:-main}"

# Asegurarse de estar dentro de un repo git
if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo "No parece ser un repositorio git. Inicializando uno..."
  git init
  git branch -M "${BRANCH}"
fi

# Asegurarse de que exista remote origin (no lo crea automáticamente por seguridad)
if ! git remote get-url origin >/dev/null 2>&1; then
  echo "No se encontró remote 'origin'. Añadelo con:"
  echo "  git remote add origin git@github.com:<tu-usuario>/Newux.git"
  echo "O usa HTTPS:"
  echo "  git remote add origin https://github.com/<tu-usuario>/Newux.git"
  exit 1
fi

git add -A
# Evitar commit vacío
if git diff --cached --quiet; then
  echo "No hay cambios para commitear."
  exit 0
fi

git commit -m "${MSG}"
git push -u origin "${BRANCH}"
echo "Todo subido a origin/${BRANCH}."
