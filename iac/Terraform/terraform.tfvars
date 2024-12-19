resource_group_name = "rg-cntenorio-dvfinlab"

# Red y subnets para las VMs
vnet_vms_name              = "vnet-common-bootcamp"
vnet_vms_address_space     = ["10.0.32.0/24"]
subnets_vnet_vms = [
  {
    name           = "sn-cntenorio"
    address_prefixes = ["10.0.32.0/24"]
  },
  
]

private_ip = "10.0.32.4"

# Red y subnet para AKS
vnet_aks_name              = "vnet-common-bootcamp"
vnet_aks_address_space     = ["10.0.32.0/24"]
subnets_vnet_aks = [
  {
    name            = "sn-cntenorio"
    address_prefixes = ["10.0.32.0/24"]
  }

]

