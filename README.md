# Newux — Plantilla para crear una distribución basada en Ubuntu

Descripción
- Newux es una plantilla para generar una ISO live/instalable basada en Ubuntu usando live-build (CLI).
- El repositorio contiene scripts, listas de paquetes y hooks para personalizar la imagen.

Estructura del repositorio
- build.sh
- upload_all.sh            -> script para subir todo desde tu máquina local al repo (git add/commit/push)
- package-lists/
  - custom.list.chroot
  - README
- hooks/
  - chroot/
    - 01-customize.sh
- .github/
  - workflows/
    - commit-artifacts.yml -> workflow para comprometer (commit) y subir artefactos generados (ej.: build-output/)
- config/
  - includes.chroot/       -> opcional: archivos que quieras incluir en la imagen final
- .gitignore
- LICENSE

Cómo usar
1. Si aún no creaste el repo en GitHub:
   - Crea un repo llamado `Newux` (privado o público según prefieras).
2. Clona el repo localmente:
   git clone git@github.com:<tu-usuario>/Newux.git
   cd Newux
3. Copia/pega estos archivos en el directorio del repo o súbelos desde la interfaz web.
4. Para subir todo desde tu máquina local con un script (rápido):
   chmod +x upload_all.sh
   ./upload_all.sh "Mensaje de commit inicial"
   (El script hará git add -A, git commit y git push a la rama main)
5. Para construir la ISO (en un host Ubuntu con live-build instalado):
   chmod +x build.sh
   sudo ./build.sh

Sobre el workflow de GitHub Actions
- El workflow ubicado en .github/workflows/commit-artifacts.yml está diseñado para usarse manualmente (workflow_dispatch) o por programación (schedule).
- Su propósito es tomar archivos en build-output/ (o la carpeta que configures) y comprometerlos de vuelta al repositorio usando el token GITHUB_TOKEN. Esto permite automatizar subir artefactos generados por CI sin crear bucles de ejecución (el workflow no está activo en `push`).

Advertencias importantes
- No publiques logos/branding de Ubuntu sin permiso si piensas redistribuir la ISO.
- Revisa y ajusta usuarios/contraseñas del hook antes de usar en producción.
- Si habilitas push automático desde Actions, asegúrate de comprender la política de commits y CI para evitar commits infinitos.

---