resource "azurerm_linux_virtual_machine" "vm" {
  name               = var.name_vm
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = "Standard_B1ms" # Tamaño de la VM
  admin_username      = "adminuser"
  admin_password    =  "Claudia1234"
  disable_password_authentication = false


  network_interface_ids = [var.network_interface_id]


  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
 
}