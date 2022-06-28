###################################################
#### Output
###################################################
data "azurerm_public_ip" "ftdv01-pubip" {
  name                = azurerm_public_ip.ftdv01-outside-public-ip.name
  resource_group_name = azurerm_linux_virtual_machine.ftdv01.resource_group_name
}

output "ftdv01-publicip-outside" {
  value = data.azurerm_public_ip.ftdv01-pubip.ip_address
}

data "azurerm_public_ip" "ftdv01-pubip-m" {
  name                = azurerm_public_ip.ftdv01-mgmt-public-ip.name
  resource_group_name = azurerm_linux_virtual_machine.ftdv01.resource_group_name
}

output "ftdv01-publicip-mgmt" {
  value = data.azurerm_public_ip.ftdv01-pubip-m.ip_address
}

data "azurerm_public_ip" "ftdv02-pubip" {
  name                = azurerm_public_ip.ftdv02-outside-public-ip.name
  resource_group_name = azurerm_linux_virtual_machine.ftdv02.resource_group_name
}

output "ftdv02-publicip-outside" {
  value = data.azurerm_public_ip.ftdv02-pubip.ip_address
}

data "azurerm_public_ip" "ftdv02-pubip-m" {
  name                = azurerm_public_ip.ftdv02-mgmt-public-ip.name
  resource_group_name = azurerm_linux_virtual_machine.ftdv02.resource_group_name
}

output "ftdv02-publicip-mgmt" {
  value = data.azurerm_public_ip.ftdv02-pubip-m.ip_address
}

data "azurerm_public_ip" "oobjmpbox-pubip" {
  name                = azurerm_public_ip.public_ip_oobjmpbox.name
  resource_group_name = azurerm_windows_virtual_machine.oobjmpbox-win.resource_group_name
}

output "oobjmpbox-publicip" {
  value = data.azurerm_public_ip.oobjmpbox-pubip.ip_address
}
