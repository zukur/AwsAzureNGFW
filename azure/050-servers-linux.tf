###################################################
#### Deploy Linux server
###################################################
resource "azurerm_linux_virtual_machine" "linux-srv" {
  name                  = "Linux-srv-${var.pod_name}"
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  network_interface_ids = [azurerm_network_interface.linux-nic.id]
  size                  = "Standard_DS1_v2"

  os_disk {
    name                 = "linux-srv-disk-${var.pod_name}"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  computer_name                   = "linux-srv-${var.pod_name}"
  admin_username                  = var.username
  admin_password                  = var.password
  disable_password_authentication = false
  custom_data = filebase64("linux_srv_startup.txt")
}
