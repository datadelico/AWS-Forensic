#!/bin/bash

# Script para montar volúmenes de evidencia en la instancia forense
# Asegura que los volúmenes se monten en modo solo lectura para preservar la integridad de los datos

# Verifica si se proporcionó un argumento (ruta del volumen)
if [ "$#" -ne 1 ]; then
    echo "Uso: $0 <ruta_del_volumen>"
    exit 1
fi

VOLUMEN=$1

# Crea un punto de montaje
PUNTO_MONTAGE="/mnt/evidencia"

# Verifica si el punto de montaje ya existe, si no, lo crea
if [ ! -d "$PUNTO_MONTAGE" ]; then
    mkdir -p "$PUNTO_MONTAGE"
fi

# Monta el volumen en modo solo lectura
mount -o ro "$VOLUMEN" "$PUNTO_MONTAGE"

# Verifica si el montaje fue exitoso
if [ $? -eq 0 ]; then
    echo "El volumen $VOLUMEN ha sido montado en $PUNTO_MONTAGE en modo solo lectura."
else
    echo "Error al montar el volumen $VOLUMEN."
    exit 1
fi