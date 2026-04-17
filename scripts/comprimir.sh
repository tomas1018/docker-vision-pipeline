#!/bin/bash

# Configuracion de rutas y archivos
DIR_ORIGEN="./imagenes"
DIR_REDUCIDAS="../imagenes_reducidas"
REPORT_TOTAL="nom_img.txt"
REPORT_VAL="nom_val.txt"
REPORT_A="nom_a.txt"

# Validacion de existencia de directorios y contenido
if [ ! -d "$DIR_ORIGEN" ] || [ -z "$(ls -A "$DIR_ORIGEN")" ]; then
    echo "Error: Carpeta de imagenes original no existe o esta vacia."
    exit 1
fi

if [ ! -d "$DIR_REDUCIDAS" ]; then
    echo "Error: Todavia no se han procesado las imagenes reducidas."
    exit 1
fi

echo "Generando listas de nombres y reportes..."

# Generar lista total de nombres (sobrescribe si ya existe)
ls "$DIR_ORIGEN" | sed 's/\.[^.]*$//' > "$REPORT_TOTAL"

# Generar lista de nombres validos (comienzan con Mayuscula)
grep -E "^[A-Z][a-z]+" "$REPORT_TOTAL" > "$REPORT_VAL"

# Generar lista de nombres que terminan con 'a'
grep -E "a$" "$REPORT_TOTAL" > "$REPORT_A"

# Empaquetado final
echo "Creando archivo comprimido final..."

# Agrupamos reportes y directorios en el tar.gz
# Usamos -zcf para modo silencioso y eficiente
tar -zcf resultado_final.tar.gz \
    "$DIR_ORIGEN" \
    "$DIR_REDUCIDAS" \
    "$REPORT_TOTAL" \
    "$REPORT_VAL" \
    "$REPORT_A"

if [ $? -eq 0 ]; then
    echo "Proceso finalizado. Archivo 'resultado_final.tar.gz' generado correctamente."
else
    echo "Error durante la creacion del paquete final."
    exit 1
fi

exit 0
