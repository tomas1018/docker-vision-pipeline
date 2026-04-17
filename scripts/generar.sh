#!/bin/bash

CANTIDAD=$1
DIR_IMG="../imagenes"
FILE_NOMBRES="../nombres.txt"
URL_DICT="https://raw.githubusercontent.com/adalessandro/EdP-2023-TP-Final/main/dict.csv"
URL_IMG="https://thispersondoesnotexist.com/"

# Validar entrada
if [[ -z "$CANTIDAD" ]] || ! [[ "$CANTIDAD" =~ ^[0-9]+$ ]] || [ "$CANTIDAD" -le 0 ]; then
    echo "Error: Ingrese un número entero válido mayor a 0."
    exit 1
fi

# Preparar entorno
if [ ! -f "$FILE_NOMBRES" ]; then
    wget -q -O "$FILE_NOMBRES" "$URL_DICT"
fi

mkdir -p "$DIR_IMG"
IFS=$'\n' read -d '' -r -a NOMBRES < "$FILE_NOMBRES"

# Descarga de imagenes
for ((i=1; i<=$CANTIDAD; i++)); do
    NOMBRE_AZAR=${NOMBRES[$RANDOM % ${#NOMBRES[@]}]}
    # Limpieza básica para evitar caracteres especiales en el nombre del archivo
    NOMBRE_LIMPIO=$(echo "$NOMBRE_AZAR" | cut -d',' -f1 | tr -d '\r')
    
    echo "Descargando imagen $i de $CANTIDAD..."
    wget -q "$URL_IMG" -O "$DIR_IMG/$NOMBRE_LIMPIO.jpg"
    
    sleep 1
done

# Empaquetado y suma de verificacion
tar -zcf imagenes.tar.gz "$DIR_IMG"
md5sum imagenes.tar.gz > "../verificacion.txt"

echo "Proceso finalizado."
exit 0


