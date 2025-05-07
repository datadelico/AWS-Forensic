#!/bin/bash

# Script para la adquisición de evidencias forenses para linux
# Este script adquiere imágenes de la memoria RAM y del disco duro

# Variables
EVIDENCE_DIR="/forensics/evidencia"
IMAGES_DIR="/forensics/imagenes"
RAM_IMAGE="ram_image.raw"
DISK_IMAGE="disk_image.dd"

# Crear directorios para almacenar evidencias
mkdir -p $EVIDENCE_DIR
mkdir -p $IMAGES_DIR

# Adquirir imagen de la memoria RAM
echo "Adquiriendo imagen de la memoria RAM..."
sudo volatility3 -f /dev/mem --output-file=$EVIDENCE_DIR/$RAM_IMAGE

# Adquirir imagen del disco
echo "Adquiriendo imagen del disco..."
sudo dd if=/dev/sda of=$IMAGES_DIR/$DISK_IMAGE bs=4M status=progress

# Finalización
echo "Adquisición de evidencias completada."