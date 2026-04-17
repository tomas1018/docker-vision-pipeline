                                                              Docker Vision Pipeline

Desarrollador: Tomas Herenu

Descripción del Proyecto

Este sistema es un pipeline automatizado desarrollado en Bash y contenedorizado con Docker. Permite la descarga masiva de imágenes, validación de integridad mediante sumas MD5, procesamiento de imágenes con ImageMagick y generacion de reportes detallados con empaquetado final. El objetivo principal es ofrecer una solución robusta y reproducible para el manejo de activos visuales mediante scripts de shell.

Requisitos Previos
Es necesario tener instalado Docker en el sistema. Puedes seguir las instrucciones oficiales según tu plataforma en el siguiente enlace:
https://docs.docker.com/engine/install/ubuntu/

Instrucciones de Uso
Clonar el repositorio:
git clone https://github.com/tomas1018/docker-vision-pipeline.git

cd docker-vision-pipeline

Construir la imagen del contenedor:
Este paso prepara el entorno con todas las dependencias necesarias (ImageMagick, wget, etc.):
docker build -t docker-vision-pipeline .

Ejecutar el contenedor:
El contenedor debe iniciarse en modo interactivo para poder interactuar con el menu de opciones:
docker run -it --name pipeline_instance docker-vision-pipeline

Menú de Opciones:

Al iniciar el contenedor, se desplegara un menú interactivo con las siguientes funcionalidades:

1 - Generar: Realiza la descarga de imágenes desde un servicio web aleatorio, asigna nombres únicos, genera el archivo de sumas de verificación verificacion.txt y comprime los archivos iniciales en imagenes.tar.gz.

2 - Descomprimir: Verifica la integridad de los datos comparando la suma MD5 actual con la registrada en verificacion.txt. Si el hash coincide, procede a la descompresión.

3 - Procesar: Filtra las imágenes según criterios de nomenclatura (nombres que inicien con Mayuscula) y realiza un redimensionamiento a 512x512 pixeles utilizando ImageMagick.

4 - Comprimir (Reportes): Ejecuta la lógica de análisis final para generar listas de nombres totales, nombres validos y nombres terminados en la letra a, empaquetando todo en el archivo final resultado_final.tar.gz.

5 - Salir: Finaliza la ejecución del programa y cierra el contenedor.

Extracción de Resultados:
Una vez finalizado el proceso, podes extraer el paquete de resultados desde el contenedor hacia tu maquina local utilizando el siguiente comando:
docker cp pipeline_instance:/docker-vision-pipeline/scripts/resultado_final.tar.gz .

Contacto:
Para consultas tecnicas o colaboraciones, podes contactarme en:
tomasfernando61@gmail.com
