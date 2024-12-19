Esquema de la Infraestructura:

    Redes Virtuales (VNets)
    ├── VNet para VMs (module.vnet_vms)
    │   ├── Subnets (module.subnets_vms)
    │   │   ├── subnet-vms-db (Máquina base de datos)
    │   │   └── subnet-vms-backup (Máquina backup)
    │   └── Peering a VNet AKS
    ├── VNet para AKS (module.vnet_aks)
    │   ├── Subnets (module.subnets_aks)
    │   │   └── subnet-aks (Clúster AKS)
    │   └── Peering a VNet VMs
    └── Peering (module.vnet_peering)
        ├── vnet-vms-to-vnet-aks
        └── vnet-aks-to-vnet-vms
    
    Recursos
    ├── Clúster AKS (module.aks_cluster)
    │   ├── Asociado a subnet-aks (module.subnets_aks)
    │   
    ├── VM Base de Datos (module.vm_db)
    │   ├── NIC (module.nic_db)
    │   │   └── Subnet: subnet-vms-db
    │   
    ├── VM Backup (module.vm_backup)
    │   ├── NIC (module.nic_backup)
    │   │   ├── Subnet: subnet-vms-backup
    │   │   └── IP Pública (azurerm_public_ip)
    │   └── NSG (module.nsg_backup)  
    └── Azure Container Registry (module.acr)

El NSG decidí borrarlo porque me daba problemas a la hora de conectar la aplicación backend con la dirección IP de la máquina virtual de la base de datos postgres.


Desde el proyecto principal se gestiona la creación de la infraestructura y también la instalación de PostgreSQL en la máquina virtual vmdb usando Ansible, además de workflows para realizar y subir backups a un Azure Storage Account y para restaurarlos en caso de fallo (aunque este último tiene un error pendiente relacionado con la ruta del backup). También existe un workflow inicial para cargar los Helm charts a Harbor. Cada proyecto de aplicación (como backend o frontend) tiene un workflow que utiliza workflows reutilizables: uno para subir imágenes a Harbor con una versión específica, otro para integración continua (CI), donde se construye y sube la imagen Docker, y otro para despliegue continuo (CD), que realiza la implementación con Helm charts. Estos workflows también incluyen una action para determinar la versión de la aplicación.



USO:

Primero, se despliega la infraestructura utilizando un workflow de GitHub Actions configurado con un dispatch que permite seleccionar la acción deseada: init, plan, apply o destroy. Desde mi máquina local, configuro un self-hosted runner en la máquina virtual vmbackup, que tiene una dirección IP pública, lo que permite ejecutar workflows de GitHub Actions directamente en esa máquina. vmbackup está conectada a la misma VNet que la máquina vmdb, que se encuentra en una red privada y no tiene acceso directo desde el exterior. Por lo tanto, los workflows pueden interactuar con vmdb a través de vmbackup, aprovechando la conectividad dentro de las subnets configuradas.

Para acceder a la vmbackup se buscar la direccion publica con el siguiente comando

    az vm list-ip-addresses --name vmbackup --resource-group rg-cntenorio-dvfinlab
    
Y se accede a través de ssh el nombre de usuario la dirección IP y seguidamente te pedirá la password.

Posteriormente, se ejecuta un workflow de Ansible para configurar servicios, y otro workflow de backup que genera copias de seguridad de la base de datos, configurado para ejecutarse automáticamente una vez al día. Desde los proyectos individuales, cualquier push a la rama main dispara los workflows de CI/CD. Esto construye, sube las imágenes Docker al registro, y despliega las aplicaciones en el clúster AKS de la infraestructura utilizando Helm charts.

Desde la terminal, el acceso al clúster AKS se configura con el comando:
    
    az aks get-credentials --resource-group nombre.grupo --name nombre.cluster


Después, se verifica que los pods estén en ejecución con:

    kubectl get pods
    kubectl get svc

![image](https://github.com/user-attachments/assets/292080ad-ac3b-408f-a20d-b727ca280abb)


Para comprobar el despliegue del frontend, se navega a la dirección IP pública asignada, donde se puede interactuar con la aplicación, como registrar un empleado en la plataforma de RRHH. Finalmente, para validar que el registro se almacenó correctamente, se accede a la máquina de base de datos vmdb y se ejecuta el siguiente comando en PostgreSQL:

![image](https://github.com/user-attachments/assets/ab58f96c-dbfe-44f1-8f65-19cbb26ef8d3)

    psql -U myuser -d rrhh

Desde allí, se realiza una consulta SQL para verificar si el registro del empleado se agregó correctamente. Esto asegura que todos los componentes del sistema (infraestructura, aplicaciones y base de datos) están funcionando correctamente.

![image](https://github.com/user-attachments/assets/fcd1a76c-2cbc-4e5f-ad97-a85e7b134da0)


