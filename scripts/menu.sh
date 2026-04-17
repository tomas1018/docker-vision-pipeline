#!/bin/bash

echo "--- Panel de Control: Pipeline de Imagenes ---"

select opcion in Generar Descomprimir Procesar Comprimir Salir
do
    case $opcion in
        "Generar")
            read -p "Ingrese la cantidad de imagenes a generar: " NUMERO
            ./generar.sh "$NUMERO"
            ;;
            
        "Descomprimir")
            read -p "Ruta del archivo comprimido (ej: ./imagenes.tar.gz): " ARCH_TAR
            read -p "Ruta del archivo de verificacion (ej: ../verificacion.txt): " ARCH_HASH
            ./descomprimir.sh "$ARCH_TAR" "$ARCH_HASH"
            ;;
            
        "Procesar")
            ./procesar.sh
            ;;
            
        "Comprimir")
            # Llamamos al script que genera reportes y empaqueta el resultado final
            ./generar_reporte.sh
            ;;
            
        "Salir")
            echo "Saliendo del programa."
            break
            ;;
            
        *)
            echo "Opcion no valida. Seleccione un numero del 1 al 5."
            ;;
    esac
    
    echo -e "\n--- Operacion finalizada. Seleccione otra opcion o Salir ---"
done

exit 0
