# output "vms_subnet_ids" {
#   value = module.subnets_vms.subnet_ids
# }

# output "aks_subnet_ids" {
#   value = module.subnets_aks.subnet_ids
# }

output "public_ip" {
  value = azurerm_public_ip.public_ip_bd.ip_address
}
