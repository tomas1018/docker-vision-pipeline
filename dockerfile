FROM ubuntu:22.04

# Evitar interacciones durante la instalacion
ENV DEBIAN_FRONTEND=noninteractive

# Instalar dependencias
RUN apt-get update && apt-get install -y imagemagick wget coreutils tar && rm -rf /var/lib/apt/lists/*

# Establecer el directorio de trabajo con el nuevo nombre del proyecto
WORKDIR /docker-vision-pipeline/scripts/

# Copiar los scripts uno por uno (asegurando consistencia de nombres)
COPY scripts/generar.sh /docker-vision-pipeline/scripts/
COPY scripts/descomprimir.sh /docker-vision-pipeline/scripts/
COPY scripts/procesar.sh /docker-vision-pipeline/scripts/
COPY scripts/generar_reporte.sh /docker-vision-pipeline/scripts/
COPY scripts/menu.sh /docker-vision-pipeline/scripts/

# Dar permisos de ejecucion
RUN chmod +x /docker-vision-pipeline/scripts/*.sh

# Definir el comando por defecto para ejecutar el menu
CMD ["bash", "/docker-vision-pipeline/scripts/menu.sh"]

# --- Comandos de referencia para ejecucion ---
# 1. Construir la imagen:
# docker build -t docker-vision-pipeline .
#
# 2. Ejecutar el contenedor (Modo Interactivo):
# docker run -it --name pipeline_instance docker-vision-pipeline
#
# 3. Extraer el resultado final a tu PC:
# docker cp pipeline_instance:/docker-vision-pipeline/scripts/resultado_final.tar.gz .