#!/bin/bash

# Uso: ./rm-submodule.sh ruta/del/submodulo
SUBMODULE_PATH=$1

if [ -z "$SUBMODULE_PATH" ]; then
    echo "Error: Debes especificar la ruta del submódulo."
    echo "Ejemplo: ./rm-submodule.sh pack/plugins/start/nvim-treesitter"
    exit 1
fi

# 1. Eliminar la entrada del submódulo en el índice de Git y los archivos de trabajo
git rm -f "$SUBMODULE_PATH"

# 2. Eliminar la sección del submódulo en .git/config
git config --remove-section "submodule.$SUBMODULE_PATH" 2>/dev/null

# 3. Eliminar la carpeta interna de Git del submódulo (limpieza de metadatos)
rm -rf ".git/modules/$SUBMODULE_PATH"

# 4. Limpiar cualquier rastro en .gitmodules (git rm suele hacerlo, pero esto asegura)
if [ -f ".gitmodules" ]; then
    git config -f .gitmodules --remove-section "submodule.$SUBMODULE_PATH" 2>/dev/null
fi

echo "-------------------------------------------------------"
echo "Submódulo '$SUBMODULE_PATH' eliminado correctamente."
echo "No olvides hacer commit: git commit -m 'Remove nvim-treesitter submodule'"
