###################################################
#### Deploy OOBjumpbox
###################################################
resource "azurerm_windows_virtual_machine" "oobjmpbox-win" {
  name                = "oobjmpbox-${var.pod_name}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  size                = "Standard_D2s_v3"
  admin_username      = var.username
  admin_password      = var.password
  network_interface_ids = [azurerm_network_interface.oobjmpbox-nic.id]

  os_disk {
    name                 = "oobjmpbox-disk-${var.pod_name}"
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsDesktop"
    offer     = "Windows-10"
    sku       = "20h1-pro"
    version   = "latest"
  }
}

###################################################
#### Deploy Jumpbox
###################################################
resource "azurerm_windows_virtual_machine" "jmpbox-win" {
  name                = "jmpbox-${var.pod_name}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  size                = "Standard_D2s_v3"
  admin_username      = var.username
  admin_password      = var.password
  network_interface_ids = [azurerm_network_interface.jmpbox-nic.id]

  os_disk {
    name                 = "jmpbox-disk-${var.pod_name}"
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsDesktop"
    offer     = "Windows-10"
    sku       = "20h1-pro"
    version   = "latest"
  }
}
