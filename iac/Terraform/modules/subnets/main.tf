# Subnets
resource "azurerm_subnet" "subnet" {
  count = length(var.subnets)
  name  = var.subnets[count.index].name
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.vnet_name
  address_prefixes     = var.subnets[count.index].address_prefixes
}




