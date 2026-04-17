#!/bin/bash

# Configuracion de rutas
DIR_ENTRADA="./imagenes"
DIR_SALIDA="../imagenes_reducidas"

# Validacion de dependencias
if ! command -v convert &> /dev/null; then
    echo "Error: ImageMagick no esta instalado."
    exit 1
fi

# Validacion de directorios
if [ ! -d "$DIR_ENTRADA" ]; then
    echo "Error: No se encontro el directorio de imagenes descompressas."
    exit 1
fi

mkdir -p "$DIR_SALIDA"

echo "Iniciando procesamiento de imagenes..."

# Contador para verificar si se proceso algo
PROCESADOS=0

for IMG in "$DIR_ENTRADA"/*.jpg; do
    # Validar si existen archivos para evitar errores en el loop
    [ -e "$IMG" ] || continue

    NOMBRE_ARCH=$(basename "$IMG")
    NOMBRE_SIN_EXT=${NOMBRE_ARCH%.*}

    # Filtro: Nombres que empiezan con Mayuscula seguida de minusculas
    if [[ $NOMBRE_SIN_EXT =~ ^[A-Z][a-z]+ ]]; then
        # Conversion a 512x512 centrada
        convert "$IMG" -gravity center -resize 512x512^ -extent 512x512 "$DIR_SALIDA/$NOMBRE_SIN_EXT.jpg"
        
        if [ $? -eq 0 ]; then
            echo "Imagen procesada: $NOMBRE_SIN_EXT"
            ((PROCESADOS++))
        fi
    fi
done

# Verificacion final
if [ $PROCESADOS -eq 0 ]; then
    echo "No se encontraron imagenes que cumplan con los requisitos de nombre."
else
    echo "Proceso finalizado. Total de imagenes reducidas: $PROCESADOS"
fi

exit 0
