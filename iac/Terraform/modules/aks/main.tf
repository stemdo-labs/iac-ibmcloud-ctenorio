resource "azurerm_kubernetes_cluster" "aks_cluster" {
  name                = "aksbootcampwe01"
  location            = var.location
  resource_group_name = "final-project-common"
  dns_prefix          = "aks-cntenorio"

  default_node_pool {
    name       = "default"
    node_count = 2
    vm_size    = "Standard_B2s" # Tamaño de las máquinas del nodo
    vnet_subnet_id = var.vnet_subnet_id

  }

  identity {
    type = "SystemAssigned" # Identidad gestionada para el clúster
  }

  network_profile {
    network_plugin     = "azure"
    load_balancer_sku  = "standard"
    outbound_type      = "loadBalancer"
  }
}