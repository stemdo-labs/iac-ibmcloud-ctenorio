resource "azurerm_container_registry" "acr" {
  name                     = "acrcntenorio"
  location                 = var.location
  resource_group_name      = var.resource_group_name
  sku                      = "Basic" 
  admin_enabled            = true
}
