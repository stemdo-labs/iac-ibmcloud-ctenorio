resource "azurerm_virtual_network_peering" "network_peering" {
  count = length(var.peerings)
  name                      = var.peerings[count.index].name
  resource_group_name       = var.peerings[count.index].resource_group_name
  virtual_network_name      = var.peerings[count.index].virtual_network_name
  remote_virtual_network_id = var.peerings[count.index].remote_virtual_network_id
  allow_virtual_network_access = var.peerings[count.index].allow_virtual_network_access
}
