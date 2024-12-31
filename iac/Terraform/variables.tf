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
  default = "r050-64f6b26f-1498-4ab1-b73b-c74d5afcf4ee"
}



