#!/bin/bash

# Asignación de parámetros
ARCHIVO_TAR=$1
ARCHIVO_HASH=$2

# Verificación de argumentos
if [ $# -ne 2 ]; then
    echo "Uso: $0 <archivo.tar.gz> <verificacion.txt>"
    exit 1
fi

# Validar existencia de archivos
if [ ! -f "$ARCHIVO_TAR" ] || [ ! -f "$ARCHIVO_HASH" ]; then
    echo "Error: Uno o ambos archivos no existen."
    exit 1
fi

# Chequeo de integridad
md5sum -c "$ARCHIVO_HASH" --status
ESTADO_MD5=$?

if [ $ESTADO_MD5 -eq 0 ]; then
    echo "Verificación exitosa. Descomprimiendo..."
    
    # Crear destino y extraer sin rutas anidadas
    mkdir -p ../imagenes_descomprimidas
    tar -xzf "$ARCHIVO_TAR" -C ../imagenes_descomprimidas --strip-components=1
    
    if [ $? -eq 0 ]; then
        echo "Proceso completado en ../imagenes_descomprimidas"
    else
        echo "Error al intentar extraer los archivos."
        exit 1
    fi
else
    echo "Error: La suma de verificación no coincide. Archivo corrupto."
    exit 1
fi

exit 0
