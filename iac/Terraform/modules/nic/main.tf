resource "azurerm_network_interface" "nic" {
  name                = var.nic_name
  location            = var.location
  resource_group_name = var.resource_group_name
  

  ip_configuration {
     name                          = var.ip_configuration_name
     subnet_id                     = var.subnet_id
     private_ip_address_allocation = "Static"
     private_ip_address            = var.private_ip
     public_ip_address_id          = var.public_ip_address_id 
   }

  # ip_configuration {
  #   name                          = var.ip_configuration_name
  #   subnet_id                     = var.subnet_id
  #   private_ip_address_allocation = var.vm_name == "vmbd" ? "Static" : "Dynamic"
  #   private_ip_address            = var.vm_name == "vmbd" ? var.private_ip : null
  #   public_ip_address_id          = var.public_ip_address_id != "" ? var.public_ip_address_id : null
  # }

}

# resource "azurerm_network_interface_security_group_association" "nic_nsg_association" {
#   network_interface_id      = azurerm_network_interface.nic.id
#   network_security_group_id = var.nsg_id
# }