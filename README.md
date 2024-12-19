# Proyecto Final Bootcamp DevOps

## Introducción

El objetivo de este proyecto es desarrollar y desplegar una aplicación completa, abarcando todas las etapas del ciclo de vida de desarrollo y adoptando una mentalidad DevOps que incluya prácticas de seguridad. 

---

## Planificación y Preparación

Antes de comenzar con el despliegue, sigue estos pasos iniciales:

0. **Brainstorming**: Lee de forma detallada `TODO` el enunciado. Piensa y esquematiza la infraestructura, y plantéate cómo enfrentar el ejercicio final. Reúnete con tus compañeros y realiza un `brainstorming` entre *todos*. Debatan y compartan sus ideas.
1. **Definir la estructura del proyecto**: Organiza los repositorios y planifica la metodología de despliegue.
2. **Esquema de infraestructura**: Crea un esquema detallado de la infraestructura que incluirá máquinas virtuales, un clúster de Kubernetes y recursos de red. ([Draw.io](https://app.diagrams.net/), [Excalidraw](https://excalidraw.com/))
3. **Revisión de la aplicación**: Examina el código de la aplicación asignada para familiarizarte con sus requisitos y componentes. Revisar ficheros de versiones (pom.xml, package.json)

---

## Desarrollo de Pipelines CI/CD

1. **Configuración de GitHub Actions**: Configura GitHub Actions para gestionar el desarrollo, pruebas, despliegue y operaciones (CI/CD) con Ansible, Terraform y Kubernetes. Debes hacer uso de `workflows` y `custom actions`.
1. **Metodología de despliegue**: La aplicación se debe poder desplegar en un entorno de desarrollo y en un entorno de producción, por lo que la estructura general y las configuraciones deben permitirlo. ¿Cómo incorporamos este requisito al CI/CD? *(Extra Mile)*
1. **Pruebas automatizadas**: Añade pruebas automatizadas (unitarias, de integración y de extremo a extremo) en los pipelines para asegurar la calidad del código. *(Extra Mile)*

---

## Infraestructura como Código (IaC)

Utiliza Terraform para definir la infraestructura requerida, prestando atención a la modularidad y parametrización:

1. **Definición de Infraestructura**:
   - VM para base de datos
   - VM para backups y DR
   - Clúster de Kubernetes
   - Container Registry

2. **Configuración de Networking**:
   - Ambas VMs deben estar en la misma red virtual.
   - El clúster de Kubernetes debe estar en otra red virtual diferente.
   
3. **Almacenamiento de `tfstate`**: Asegúrate de que el archivo `tfstate` esté en el Storage Account disponible en el Resource Group asignado (nomenclatura: `rg-<nombre>-dvfinlab`).

> Notas: <br>
> Las máquinas virtuales deben ser de tipo `Standard_B1ms`. Los nodos de Kubernetes usan máquinas tipo `Standard_B2s`. 
>
> A fin de garantizar una mayor seguridad, ¿cuáles recursos deberían disponer de una IP pública y cuáles no? 
>
> ¿Cómo podemos llegar a esos recursos privados desde GitHub Actions?

---

## Contenerización de Aplicaciones

1. **Desarrollo de Dockerfiles**: Crea Dockerfiles utilizando el enfoque *Multistage Build* para construir las imágenes de backend y frontend de la aplicación.
2. **Publicación en el Container Registry**: Las imágenes se deben subir al Container Registry y ser consumidas desde allí para su despliegue.

> Nota: ¿De qué recurso de networking se debe hacer uso para que el backend y el frontend logren comunicarse entre sí?

---

## Despliegue en Kubernetes

1. **Manifiestos de Kubernetes**:
   - Asegura que haya dos réplicas para cada micro.
   - Configura memoria y CPU dedicadas para cada pod.
   - Asegura que un pod no reciba tráfico hasta que esté completamente operativo.
   - Configura un nodo de Kubernetes con escalabilidad a dos nodos. *(Extra Mile)*

2. **Creación y Despliegue de Helm Chart**:
   - Crea un chart de Helm que use los manifiestos de Kubernetes como template para desplegar la aplicación.
   - Utiliza variables, operaciones, bucles y todo lo que considere necesario para lograr que el chart sea reutilizable en diferentes entornos.
   - Se va a hacer uso de Harbor para almacenar el chart creado y desde allí se desplegará en el clúster de Azure.

---

## Automatización de Operaciones y Recuperación ante Desastres

1. **Aprovisionamiento y Configuración de la BBDD**: Automatiza la instalación y configuración del motor de base de datos PostgreSQL en la VM correspondiente, usando Ansible.
2. **Automatización de Backups**: Desarrolla playbooks de Ansible para la gestión de backups y envía copias de seguridad cifradas al Storage Account proporcionado.
3. **Pruebas de Disaster Recovery**: Verifica regularmente el plan de recuperación para asegurarte de que las restauraciones funcionan correctamente.

---

## Seguridad 

1. **Restricción de Acceso**: Solo el backend debe tener acceso a la base de datos, y solo el frontend debe ser accesible desde el cliente.
1. **Cifrado de comunicaciones**: Asegura que todas las comunicaciones entre servicios estén encriptadas. *(Extra Mile)*
1. **Políticas de Seguridad en Kubernetes**: Implementa Network Policies y Pod Security Policies para controlar el acceso entre servicios. *(Extra Mile)*

---

## Monitoreo y Logging 

1. **Implementación de Monitoreo y Logging**: Añade soluciones de monitoreo y registro de logs para todas las capas de la aplicación. *(Extra Mile)*
2. **Herramientas Sugeridas**: Utiliza Prometheus y Grafana para monitoreo, y ELK Stack (Elasticsearch, Logstash y Kibana) para obtener métricas y logs detallados. *(Extra Mile)*

---

## Estructura de la solución

Se le entregarán 3 repositorios: el presente, el del backend de la app y el del frontend de la app. Los ficheros Dockerfile y configuraciones de networking que considere oportunas, irán en los repositorios de la aplicación. El resto de entregables irán en este repositorio y deben respetar la estructura de directorios presente, para lograr una correcta entrega de todos los elementos y facilitar las correcciones a los tutores. Las soluciones que no respeten esta estructura *mínima* y no estén dentro de la carpeta que corresponda, serán considerados como `no entregados`. Si considera que debe agregar algún fichero o directorio a la estructura, puede hacerlo, siempre que se respete lo dicho antes.