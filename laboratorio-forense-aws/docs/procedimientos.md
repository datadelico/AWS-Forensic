# Procedimientos a seguir en el laboratorio forense

## 1. Preparación del entorno

Antes de comenzar con la adquisición de evidencias, es fundamental preparar el entorno forense. Esto incluye:

- **Desplegar la infraestructura en AWS**: Utilizar el archivo `forense-lab.json` de CloudFormation para crear la instancia de Ubuntu 22 y los volúmenes de almacenamiento necesarios.
- **Configurar la seguridad**: Asegurarse de que las configuraciones de seguridad permiten el acceso adecuado a la instancia y protegen la integridad de los datos.

## 2. Instalación de herramientas forenses

Una vez que la instancia esté en funcionamiento, se deben instalar las herramientas necesarias. Para ello, ejecutar el script `setup-tools.sh`, que instalará:

- **Volatility3**: Herramienta para análisis de memoria.
- **Lime**: Herramienta para adquisición de memoria.

## 3. Montaje de volúmenes de evidencia

Antes de realizar la adquisición de evidencias, es necesario montar los volúmenes de evidencia. Utilizar el script `mount-evidence.sh` para:

- Montar los volúmenes en modo solo lectura.
- Verificar que los volúmenes se han montado correctamente.

## 4. Adquisición de evidencias

Con el entorno preparado y las herramientas instaladas, se puede proceder a la adquisición de evidencias. Ejecutar el script `acquisition.sh`, que realizará las siguientes acciones:

- Capturar la memoria RAM de la instancia.
- Crear imágenes de disco de los volúmenes montados.

## 5. Manejo de la evidencia

Después de la adquisición, es crucial manejar la evidencia de manera adecuada:

- **Almacenamiento**: Seguir las instrucciones en `forensics/evidencia/README.md` para almacenar la evidencia de forma segura.
- **Documentación**: Registrar todos los pasos realizados y los hallazgos en los reportes, siguiendo las pautas en `forensics/reportes/README.md`.

## 6. Análisis de imágenes de disco

Las imágenes de disco adquiridas deben ser analizadas siguiendo las directrices en `forensics/imagenes/README.md`. Esto incluye:

- Utilizar herramientas forenses para analizar el contenido de las imágenes.
- Documentar los hallazgos y conclusiones.

## 7. Cierre del proceso forense

Finalmente, una vez completado el análisis, se debe cerrar el proceso forense:

- Asegurarse de que toda la evidencia esté debidamente documentada y almacenada.
- Realizar un informe final que resuma los hallazgos y las acciones tomadas durante el proceso forense.