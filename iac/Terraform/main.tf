terraform {
  required_version = ">=0.12"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.5.0" # Versión del proveedor Azure
    }
  }

  # Configuración del backend para almacenar el tfstate 
   backend "azurerm" {
     resource_group_name  = "rg-cntenorio-dvfinlab"
     storage_account_name = "stacntenoriodvfinlab"
     container_name       = "tfstatecont"
     key                  = "terraform.tfstate"
   }
}

provider "azurerm" {
  features {} 
}

 
# module "vnet_vms" {
#     source = "./modules/vnet"
#     location = var.location
#     resource_group_name = var.resource_group_name
#     vnet_name = var.vnet_vms_name
#     vnet_address_space = var.vnet_vms_address_space
#     subnets = var.subnets_vnet_vms
# }

# module "vnet_aks" {
#     source = "./modules/vnet"
#     location = "North Europe"
#     resource_group_name = var.resource_group_name
#     vnet_name = var.vnet_aks_name
#     vnet_address_space = var.vnet_aks_address_space
#     subnets = var.subnets_vnet_aks
# }

#subnets
# Subnet para la base de datos dentro de la red privada
# module "subnets_vms" {
#   source = "./modules/subnets"
#   resource_group_name = var.resource_group_name
#   location =  var.location
#   vnet_name =  var.vnet_vms_name
#   subnets = var.subnets_vnet_vms
#   depends_on = [ module.vnet_vms]
# }


# Subnet para el clúster AKS dentro de la red pública
# module "subnets_aks" {
#   source = "./modules/subnets"
#   resource_group_name = var.resource_group_name
#   location = "North Europe"
#   vnet_name = var.vnet_aks_name
#   subnets = var.subnets_vnet_aks
#   depends_on = [ module.vnet_aks]
# }

# Peering entre la red de VMs (Privada) y la red de AKS (Pública)
# module "vnet_peering" {
#   source = "./modules/peering"

#   peerings = [
#     {
#       name                      = "vnet-vms-to-vnet-aks"
#       resource_group_name       = var.resource_group_name
#       virtual_network_name      = module.vnet_vms.vnet_name
#       remote_virtual_network_id = "61e5e3f1-31b2-455d-b9bb-f6db5bee333c"
#       allow_virtual_network_access = true
#     },
#     {
#       name                      = "vnet-aks-to-vnet-vms"
#       resource_group_name       = var.resource_group_name
#       virtual_network_name      = module.vnet_aks.vnet_name
#       remote_virtual_network_id = module.vnet_vms.vnet_id
#       allow_virtual_network_access = true
#     }
#   ]

#   depends_on = [ module.subnets_vms, module.subnets_aks]
# }


#  #Clúster de Kubernetes en la red pública
# module "aks_cluster" {
#   source = "./modules/aks"
#   location            = "North Europe"
#   resource_group_name = var.resource_group_name
#   vnet_subnet_id = module.subnets_aks.subnet_ids["subnet-aks"]
#   depends_on = [ module.vnet_peering]
#  }

# Máquina virtual para base de datos
module "vm_db"{
  source = "./modules/vm"
  location = var.location
  name_vm = "vmdb"
  resource_group_name = var.resource_group_name
  network_interface_id = module.nic_db.nic_id
  depends_on = [ module.nic_db ]
}

# # NIC para VM de base de datos
module "nic_db" {
  source = "./modules/nic"
  location = var.location
  resource_group_name = var.resource_group_name
  nic_name = "nic-db"
  subnet_id  =  "/subscriptions/86f76907-b9d5-46fa-a39d-aff8432a1868/resourceGroups/final-project-common/providers/Microsoft.Network/virtualNetworks/vnet-common-bootcamp/subnets/sn-cntenorio"
  ip_configuration_name = "ipconfig-db"
  public_ip_address_id = azurerm_public_ip.public_ip_bd.id 
  private_ip = var.private_ip
  vm_name = "vmdb"
  #nsg_id = module.nsg_backup.nsg_id
  #depends_on = [ module.vnet_peering ]
}


# # Máquina virtual para backups
# module "vm_backup"{
#   source = "./modules/vm"
#   name_vm = "vmbackup"
#   location = var.location
#   resource_group_name = var.resource_group_name
#   network_interface_id = module.nic_backup.nic_id
#   depends_on = [ module.nic_backup ]
# }

resource "azurerm_public_ip" "public_ip_bd" {
  name                = "public-ip-bd"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Dynamic"  
  sku                 = "Basic"
}


# resource "azurerm_public_ip" "public_ip_backup" {
#   name                = "public-ip-backup"
#   location            = var.location
#   resource_group_name = var.resource_group_name
#   allocation_method   = "Dynamic"  
#   sku                 = "Basic"
# }

# #NSG para ip 
# module "nsg_backup" {
#   source              = "./modules/nsg"
#   nsg_name            = "nsg-backup"
#   location            = var.location
#   resource_group_name = var.resource_group_name

#   security_rules = [
#     {
#       name                        = "allow-ssh"
#       priority                    = 100
#       direction                   = "Inbound"
#       access                      = "Allow"
#       protocol                    = "Tcp"
#       source_port_range           = "*" 
#       destination_port_range      = "22" #para ssh
#       source_address_prefix       = "*"  
#       destination_address_prefix  = "*"
#     }
#   ]
# }



# # NIC para VM de backups
# module "nic_backup" {
#   source = "./modules/nic"
#   location = var.location
#   resource_group_name = var.resource_group_name
#   nic_name = "nic-backup"
#   subnet_id  =  "/subscriptions/86f76907-b9d5-46fa-a39d-aff8432a1868/resourceGroups/final-project-common/providers/Microsoft.Network/virtualNetworks/vnet-common-bootcamp/subnets/sn-cntenorio"
#   ip_configuration_name = "ipconfig-backup"
#   private_ip = var.private_ip
#   vm_name = "vmbackup"
#   public_ip_address_id = azurerm_public_ip.public_ip_backup.id 
#   #nsg_id = module.nsg_backup.nsg_id 
#   depends_on = [ module.nsg_backup]
# }

# Registro de contenedores Azure (ACR)
module "acr" {
  source = "./modules/acr"
  location            = var.location
  resource_group_name = var.resource_group_name
}



