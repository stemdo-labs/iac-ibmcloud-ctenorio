variable "resource_group_name" {}

variable "location" {}

variable "nic_name" {}

variable "vm_name" {}


variable "ip_configuration_name" {}

variable "subnet_id" {}

variable "private_ip" {}

variable "public_ip_address_id" {}

variable "nsg_id" {
  description = "ID del NSG asociado"
  type        = string
  default     = null
}
