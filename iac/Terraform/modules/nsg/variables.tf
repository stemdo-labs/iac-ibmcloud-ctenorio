variable "nsg_name" {
  description = "Nombre del Network Security Group"
  type        = string
}

variable "location" {
}

variable "resource_group_name" {}

variable "security_rules" {
  description = "Lista de reglas de seguridad para el NSG"
  type = list(object({
    name                        = string
    priority                    = number
    direction                   = string
    access                      = string
    protocol                    = string
    source_port_range           = string
    destination_port_range      = string
    source_address_prefix       = string
    destination_address_prefix  = string
  }))
  default = []
}
