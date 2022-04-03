#### INSTANCE CONFIGURATION ####

# Load startup data
# Get Custom data
data "template_file" "startup_file_fmc" {
  template = file("fmc_startup_file.txt")
}

data "template_file" "startup_file_ftdv01" {
  template = file("ftdv01_startup_file.txt")
  vars = {
    "fmc_ip" = var.fmc_ip
    "password" = var.password
  }
}

data "template_file" "startup_file_ftdv02" {
  template = file("ftdv02_startup_file.txt")
  vars = {
    "fmc_ip" = var.fmc_ip
    "password" = var.password
  }
}

data "template_file" "startup_file_linux_srv" {
  template = file("linux_srv_startup.txt")
}

# Create virtual machine
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
  custom_data = base64encode(data.template_file.startup_file_ftdv01.rendered)
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
  custom_data = base64encode(data.template_file.startup_file_ftdv02.rendered)
  disable_password_authentication = false
}