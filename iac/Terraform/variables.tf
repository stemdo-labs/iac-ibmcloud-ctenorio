variable "ibmcloud_api_key" {
  description = "API key"
  type        = string
}

variable "resource_group_id" {
  description = "Resource group ID"
  type        = string
}

variable "region" {
  description = "Region"
  type        = string
  default = "eu-es"
}

variable "zone" {
  description = "Zona"
  type        = string
    default = "eu-es-1"
}

variable "public_ssh_key" {
  description = "ssh key"
  type        = string
}

variable "vpc_cluster_id" {
  description = "VPC cluster id"
  type        = string
  default = "r050-4bd8bde6-760a-4fa0-a88f-989f1fcbc107"
}

variable "bastion_public_ip" {
  description = "IP pública del bastion host (clúster)"
  type        = string
  default     = "13.120.87.224" 
}



