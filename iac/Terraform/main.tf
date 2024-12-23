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
  region = var.region
}

# Virtual Private Cloud (VPC)
resource "ibm_is_vpc" "vpc" {
  name              = "vpc-vm-ctenorio"
  resource_group    = var.resource_group_id

}


# SSH Key
resource "ibm_is_ssh_key" "ssh_key" {
  name       = "ssh-key-ctenorio"
  public_key = var.public_ssh_key
  type       = "rsa"
  resource_group = var.resource_group_id
  depends_on = [ibm_is_vpc.vpc]
}



# Subnet vm
resource "ibm_is_subnet" "subnet_vm" {
  name              = "subnet-vm"
  ipv4_cidr_block   = "10.242.0.0/24"
  vpc               = ibm_is_vpc.vpc.id
  zone              = var.zone
  resource_group    = var.resource_group_id
  depends_on = [ibm_is_vpc.vpc]
}

# Public IP
resource "ibm_is_floating_ip" "public_ip_db" {
  name   = "public-ip-db"
  target = ibm_is_instance.vm_db.primary_network_interface[0].id
  resource_group = var.resource_group_id
  depends_on = [ibm_is_instance.vm_db]
}

resource "ibm_is_security_group" "ssh_security_group" {
  name   = "ssh-security-group-cntenorio"
  vpc    = ibm_is_vpc.vpc.id
  resource_group = var.resource_group_id
  depends_on = [ibm_is_vpc.vpc]
}
 
# Crear una regla para habilitar el puerto 22 (SSH)
resource "ibm_is_security_group_rule" "allow_ssh" {
  direction      = "inbound"
  remote         = "0.0.0.0/0"

  group =  ibm_is_security_group.ssh_security_group.id
  
  tcp {
    port_min       = 22
    port_max       = 22
  }

  depends_on = [ibm_is_security_group.ssh_security_group]
  
}
resource "ibm_is_security_group_rule" "allow_outbound" {
  direction      = "outbound"
  remote         = "0.0.0.0/0"

  group =  ibm_is_security_group.ssh_security_group.id

  depends_on = [ibm_is_security_group.ssh_security_group]
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
    security_groups   = [ibm_is_security_group.ssh_security_group.id]

    primary_ip {
      auto_delete = false
      address     = "10.242.0.4"
    }
  }

  keys = [ ibm_is_ssh_key.ssh_key.id ]
  depends_on = [ibm_is_subnet.subnet_vm, ibm_is_security_group.ssh_security_group]

}

# IBM Container Registry (ICR)
resource "ibm_cr_namespace" "rg_namespace" {
  name              = "ctenorio-cr"
  resource_group_id = var.resource_group_id
}

resource "ibm_resource_instance" "cos_instance" {
  name     = "os_instance"
  service  = "cloud-object-storage"
  plan     = "standard"
  location = "global"
  resource_group_id = var.resource_group_id
}

