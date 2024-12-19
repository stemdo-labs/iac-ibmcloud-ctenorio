output "subnets" {
  description = "IDs de las subnets creadas"
  value       = [for s in azurerm_subnet.subnet : s.id]
}

output "subnet_ids" {
  value = { for subnet in azurerm_subnet.subnet : subnet.name => subnet.id }
}
