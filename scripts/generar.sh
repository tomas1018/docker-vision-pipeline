#!/bin/bash

# CONFIGURACION
CANTIDAD=$1
DIR_IMG="../imagenes"
FILE_NOMBRES="../nombres.txt"
URL_DICT="https://raw.githubusercontent.com/adalessandro/EdP-2023-TP-Final/main/dict.csv"
URL_IMG="https://thispersondoesnotexist.com/"

# --- VALIDACIÓN ---
# Verifica que se haya pasado un argumento y que sea un número mayor a 0
if [[ -z "$CANTIDAD" ]] || ! [[ "$CANTIDAD" =~ ^[0-9]+$ ]] || [ "$CANTIDAD" -le 0 ]; then
    echo "Error: Por favor, ingrese un número entero válido mayor a 0."
    echo "Uso: $0 [cantidad]"
    exit 1
fi

echo Iniciando proceso para generar $CANTIDAD imágenes..."

# --- PREPARACIÓN ---
# Descarga el diccionario solo si no existe
if [ ! -f "$FILE_NOMBRES" ]; then
    echo "Descargando diccionario de nombres..."
    wget -q -O "$FILE_NOMBRES" "$URL_DICT"
fi

mkdir -p "$DIR_IMG"

# Leer nombres en un array
IFS=$'\n' read -d '' -r -a NOMBRES < "$FILE_NOMBRES"

# PROCESAMIENTO
for ((i=1; i<=$CANTIDAD; i++)); do
    # Elige un nombre al azar
    NOMBRE=${NOMBRES[$RANDOM % ${#NOMBRES[@]}]}
    # Limpia el nombre de posibles caracteres extraños o comas
    NOMBRE_LIMPIO=$(echo "$NOMBRE" | cut -d',' -f1 | tr -d '\r')
    
    echo "[$i/$CANTIDAD] Descargando imagen para: $NOMBRE_LIMPIO..."
    
    wget -q "$URL_IMG" -O "$DIR_IMG/$NOMBRE_LIMPIO.jpg"
    
    # Agregamos un pequeño retraso
    sleep 1
done

# EMPAQUETADO 
echo "Comprimiendo imágenes..."
tar -zcvf imagenes.tar.gz "$DIR_IMG" > /dev/null

echo "Generando suma de verificación..."
md5sum imagenes.tar.gz > "../verificacion.txt"

echo "¡Proceso finalizado con éxito!"
exit 0


