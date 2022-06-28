###################################################
#### Deploy FTDs
###################################################
resource "azurerm_linux_virtual_machine" "ftdv01" {
  name                  = "ftdv01-${var.pod_name}"
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  depends_on = [azurerm_network_interface.ftdv01-mgmt, azurerm_network_interface.ftdv01-diag, azurerm_network_interface.ftdv01-outside, azurerm_network_interface.ftdv01-inside]
  network_interface_ids = [azurerm_network_interface.ftdv01-mgmt.id, azurerm_network_interface.ftdv01-diag.id, azurerm_network_interface.ftdv01-outside.id, azurerm_network_interface.ftdv01-inside.id]
  size                  = "Standard_D3_v2" 

  plan {
    name = "ftdv-azure-byol"
    publisher = "cisco"
    product = "cisco-ftdv"
  }

  source_image_reference {
    publisher = "cisco"
    offer     = "cisco-ftdv"
    sku       = "ftdv-azure-byol"
    version   = var.ftd_version
  }
  os_disk {
    name              = "ftdv01-disk-${var.pod_name}"
    caching           = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  admin_username = var.username
  admin_password = var.password
  computer_name  = "ftdv01"
  custom_data = base64encode(templatefile("ftdv01_startup_file.txt", {fmc_ip = var.fmc_ip, password = var.password}))
  disable_password_authentication = false
}

resource "azurerm_linux_virtual_machine" "ftdv02" {
  name                  = "ftdv02-${var.pod_name}"
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  depends_on = [azurerm_network_interface.ftdv02-mgmt, azurerm_network_interface.ftdv02-diag, azurerm_network_interface.ftdv02-outside, azurerm_network_interface.ftdv02-inside]
  network_interface_ids = [azurerm_network_interface.ftdv02-mgmt.id, azurerm_network_interface.ftdv02-diag.id, azurerm_network_interface.ftdv02-outside.id, azurerm_network_interface.ftdv02-inside.id]
  size                  = "Standard_D3_v2" 

  plan {
    name = "ftdv-azure-byol"
    publisher = "cisco"
    product = "cisco-ftdv"
  }

  source_image_reference {
    publisher = "cisco"
    offer     = "cisco-ftdv"
    sku       = "ftdv-azure-byol"
    version   = var.ftd_version
  }
  os_disk {
    name              = "ftdv02-disk-${var.pod_name}"
    caching           = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  admin_username = var.username
  admin_password = var.password
  computer_name  = "ftdv02"
  custom_data = base64encode(templatefile("ftdv02_startup_file.txt", {fmc_ip = var.fmc_ip, password = var.password}))
  disable_password_authentication = false
}