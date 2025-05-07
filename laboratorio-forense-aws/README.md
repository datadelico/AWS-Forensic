# Laboratorio Forense en AWS

Este proyecto tiene como objetivo crear un laboratorio forense en la nube utilizando Amazon Web Services (AWS) y Ubuntu 22. El laboratorio está diseñado para facilitar la adquisición y análisis de evidencias digitales, proporcionando un entorno seguro y controlado.

## Estructura del Proyecto

El proyecto está organizado en varias carpetas, cada una con un propósito específico:

- **cloudformation/**: Contiene los archivos necesarios para desplegar la infraestructura en AWS utilizando CloudFormation.
  - `forense-lab.json`: Plantilla de CloudFormation para desplegar una instancia de Ubuntu 22 y volúmenes de almacenamiento.
  - `parameters.json`: Parámetros personalizables para la plantilla de CloudFormation.

- **scripts/**: Incluye scripts que automatizan la instalación y configuración de herramientas forenses.
  - `setup-tools.sh`: Script para instalar herramientas como Volatility3 y Lime.
  - `mount-evidence.sh`: Script para montar volúmenes de evidencia en modo solo lectura.
  - `acquisition.sh`: Script para realizar la adquisición de evidencias forenses.

- **docs/**: Documentación relacionada con los procedimientos y herramientas utilizadas en el laboratorio.
  - `procedimientos.md`: Detalles sobre los procedimientos a seguir durante el proceso forense.
  - `herramientas.md`: Información sobre las herramientas utilizadas en el laboratorio.

- **forensics/**: Carpeta dedicada a la gestión de la evidencia y reportes.
  - `evidencia/README.md`: Instrucciones sobre el manejo y almacenamiento de la evidencia.
  - `imagenes/README.md`: Descripción sobre la gestión y análisis de imágenes de disco.
  - `reportes/README.md`: Documentación de los reportes generados durante el proceso forense.

- **tools/**: Contiene configuraciones específicas para las herramientas forenses.
  - `config/tool-config.json`: Archivo de configuración para personalizar el comportamiento de las herramientas.

- **.gitignore**: Especifica los archivos y directorios que deben ser ignorados por el sistema de control de versiones.

## Despliegue del Entorno

Para desplegar el entorno en AWS, sigue estos pasos:

1. Asegúrate de tener una cuenta de AWS y las credenciales configuradas.
2. Modifica el archivo `parameters.json` según tus necesidades (tipo de instancia, tamaño de volúmenes, etc.).
3. Utiliza la consola de AWS o la CLI para crear un stack de CloudFormation utilizando el archivo `forense-lab.json`.
4. Una vez desplegada la infraestructura, conecta a la instancia de Ubuntu 22 y ejecuta los scripts en la carpeta `scripts/` para configurar el entorno forense, `setup-tools.sh`.

## Contribuciones

Las contribuciones son bienvenidas. Si deseas mejorar este proyecto, por favor abre un issue o envía un pull request.

## Licencia

Este proyecto está bajo la Licencia MIT.