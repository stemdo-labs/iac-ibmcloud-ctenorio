terraform {
  required_version = ">=0.12"

  required_providers {
    ibm = {
      source = "IBM-Cloud/ibm"
      version = ">= 1.12.0"
    }
  }
}

provider "ibm" {
  ibmcloud_api_key = var.ibmcloud_api_key
}

# Virtual Private Cloud (VPC)
resource "ibm_is_vpc" "vpc" {
  name              = "vpc-final-project"
  resource_group    = var.resource_group_id
  classic_access    = false

  default_network_acl {
    name = "default-acl"
  }
  default_security_group {
    name = "default-sg"
  }
}

# Subnet
resource "ibm_is_subnet" "subnet_db" {
  name              = "subnet-db"
  ipv4_cidr_block   = "10.0.242.0/24"
  vpc               = ibm_is_vpc.vpc.id
  zone              = var.zone
  resource_group    = var.resource_group_id
}

# Public IP
resource "ibm_is_floating_ip" "public_ip_db" {
  name   = "public-ip-db"
  region = var.region
}

# Network Interface
resource "ibm_is_instance_interface" "nic_db" {
  name       = "nic-db"
  subnet     = ibm_is_subnet.subnet_db.id
  primary    = true
  security_groups = [ibm_is_vpc.vpc.default_security_group]
}

# Máquina Virtual (VM) para la base de datos
resource "ibm_is_instance" "vm_db" {
  name              = "vmdb"
  vpc               = ibm_is_vpc.vpc.id
  zone              = var.zone
  image             = "r018-941eb02e-ceb9-44c8-895b-b31d241f43b5" 
  profile           = "bx2-2x8"
  resource_group = var.resource_group_id

    primary_network_interface {
    subnet            = ibm_is_subnet.subnet_vm.id
    allow_ip_spoofing = true
    
    primary_ip {
      auto_delete = false
      address     = "10.242.0.4"
    }
  }

}

# IBM Container Registry (ICR)
resource "ibm_cr_namespace" "icr" {
  name            = "icr-final-project"
  resource_group  = var.resource_group_id
  location        = var.region
}
