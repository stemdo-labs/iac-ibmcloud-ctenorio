variable "resource_group_name" {
  description = "Nombre del Resource Group"
  type        = string
}

variable "location" {
  description = "Ubicación donde se desplegarán los recursos"
  type        = string
  default     = "uksouth"
}

# Variables para la VNet y subnets de las VMs
variable "vnet_vms_name" {
  description = "Nombre de la red virtual para las VMs"
}

variable "vnet_vms_address_space" {
  description = "Espacio de direcciones para la red de VMs"
  type        = list(string)
}

variable "subnets_vnet_vms" {
    description = "Lista de subnets"
    type = list(object({
        name = string
        address_prefixes = list(string)
    }))
}

# Variables para la VNet y subnet de Kubernetes
variable "vnet_aks_name" {
  description = "Nombre de la red virtual para AKS"
}

variable "vnet_aks_address_space" {
  description = "Espacio de direcciones para la red de AKS"
  type        = list(string)
}

variable "subnets_vnet_aks" {
    description = "Lista de subnets"
    type = list(object({
        name = string
        address_prefixes = list(string)
    }))
}

variable "private_ip" {
  description = "ID de la IP pública "
  type        = string
  default     = ""  
}


variable "public_ip_address_id" {
  description = "ID de la IP pública "
  type        = string
  default     = ""  
}

variable  "private_ip_vm_db" {
  description = "ID de la IP pública "
  type        = string
  default     = ""  

}

