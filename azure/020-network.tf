###################################################
#### Create Virtual Network
###################################################
resource "azurerm_virtual_network" "vnet" {
  name                = "BTH-MC-VNET-${var.pod_name}"
  address_space       = ["10.41.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

###################################################
#### Create subnets
###################################################
resource "azurerm_subnet" "subnet_outside" {
  name                 = "Outside-${var.pod_name}"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.41.1.0/24"]
}

resource "azurerm_subnet" "subnet_inside" {
  name                 = "Inside-${var.pod_name}"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.41.2.0/24"]
}

resource "azurerm_subnet" "subnet_mgmt" {
  name                 = "Management-${var.pod_name}"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.41.3.0/24"]
}

resource "azurerm_subnet" "subnet_jumpbox" {
  name                 = "Jumpbox-${var.pod_name}"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.41.4.0/24"]
}

resource "azurerm_subnet" "subnet_oobmgmt" {
  name                 = "OOB-mgmt-${var.pod_name}"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.41.250.0/24"]
}

resource "azurerm_subnet" "subnet_diag" {
  name                 = "Diag-${var.pod_name}"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.41.255.0/24"]
}

###################################################
#### Create route table
###################################################
resource "azurerm_route_table" "internal-to-ftd" {
  name                = "internal-to-ftd-${var.pod_name}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  disable_bgp_route_propagation = false
  
  route {
    name = "to-ftd-${var.pod_name}"
    address_prefix = "0.0.0.0/0"
    next_hop_type = "VirtualAppliance"
    next_hop_in_ip_address = "10.41.2.4"
  }
}

###################################################
#### Associate Route Table with Subnet
###################################################
resource "azurerm_subnet_route_table_association" "inside-rt" {
  subnet_id = azurerm_subnet.subnet_jumpbox.id
  route_table_id = azurerm_route_table.internal-to-ftd.id
}

###################################################
#### Create public IPs
###################################################
resource "azurerm_public_ip" "public_ip_oobjmpbox" {
  name                = "oobjumpbox-public-ip-${var.pod_name}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Dynamic"
}

resource "azurerm_public_ip" "ftdv01-outside-public-ip" {
    name                         = "ftdv01-outside-public-ip-${var.pod_name}"
    location                     = azurerm_resource_group.rg.location
    resource_group_name          = azurerm_resource_group.rg.name
    allocation_method            = "Static"
    sku                          = "Standard"
}

resource "azurerm_public_ip" "ftdv01-mgmt-public-ip" {
    name                         = "ftdv01-mgmt-public-ip-${var.pod_name}"
    location                     = azurerm_resource_group.rg.location
    resource_group_name          = azurerm_resource_group.rg.name
    allocation_method            = "Static"
    sku                          = "Standard"
}

resource "azurerm_public_ip" "ftdv02-outside-public-ip" {
    name                         = "ftdv02-outside-public-ip-${var.pod_name}"
    location                     = azurerm_resource_group.rg.location
    resource_group_name          = azurerm_resource_group.rg.name
    allocation_method            = "Static"
    sku                          = "Standard"
}

resource "azurerm_public_ip" "ftdv02-mgmt-public-ip" {
    name                         = "ftdv02-mgmt-public-ip-${var.pod_name}"
    location                     = azurerm_resource_group.rg.location
    resource_group_name          = azurerm_resource_group.rg.name
    allocation_method            = "Static"
    sku                          = "Standard"
}
