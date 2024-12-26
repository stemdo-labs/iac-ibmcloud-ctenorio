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
  default = "r050-a31d6fda-8952-48f3-9159-30b8635834b0"
}

variable "bastion_public_ip" {
  description = "IP pública del bastion host (clúster)"
  type        = string
  default     = "13.120.87.171" 
}



