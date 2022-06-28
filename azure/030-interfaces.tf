###################################################
#### Create Network Interfaces
###################################################
resource "azurerm_network_interface" "oobjmpbox-nic" {
  name                = "oobjmpbox-nic-${var.pod_name}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "oobjmpbox-ip-${var.pod_name}"
    subnet_id                     = azurerm_subnet.subnet_oobmgmt.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.41.250.100" 
    public_ip_address_id          = azurerm_public_ip.public_ip_oobjmpbox.id
  }
}

resource "azurerm_network_interface" "jmpbox-nic" {
  name                = "jmpbox-nic-${var.pod_name}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "jmpbox-ip-${var.pod_name}"
    subnet_id                     = azurerm_subnet.subnet_jumpbox.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.41.4.100"
  }
}

resource "azurerm_network_interface" "linux-nic" {
  name                = "linux-srv-nic-${var.pod_name}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "linux-ip-${var.pod_name}"
    subnet_id                     = azurerm_subnet.subnet_jumpbox.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.41.4.101"
  }
}

resource "azurerm_network_interface" "ftdv01-mgmt" {
  name                = "ftdv01-mgmt-${var.pod_name}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "ftdv01-mgmt-ip-${var.pod_name}"
    subnet_id                     = azurerm_subnet.subnet_mgmt.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.41.3.10"
    public_ip_address_id          = azurerm_public_ip.ftdv01-mgmt-public-ip.id
  }
}

resource "azurerm_network_interface" "ftdv01-diag" {
  name                = "ftdv01-diag-${var.pod_name}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "ftdv01-diag-ip-${var.pod_name}"
    subnet_id                     = azurerm_subnet.subnet_diag.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.41.255.10"
  }
}

resource "azurerm_network_interface" "ftdv01-outside" {
  name                = "ftdv01-outside-${var.pod_name}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  enable_ip_forwarding = true

  ip_configuration {
    name                          = "ftdv01-outside-ip-${var.pod_name}"
    subnet_id                     = azurerm_subnet.subnet_outside.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.41.1.10"
    public_ip_address_id          = azurerm_public_ip.ftdv01-outside-public-ip.id
  }
}

resource "azurerm_network_interface" "ftdv01-inside" {
  name                = "ftdv01-inside-${var.pod_name}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  enable_ip_forwarding = true

  ip_configuration {
    name                          = "ftdv01-inside-ip-${var.pod_name}"
    subnet_id                     = azurerm_subnet.subnet_inside.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.41.2.10"
  }
}

resource "azurerm_network_interface" "ftdv02-mgmt" {
  name                = "ftdv02-mgmt-${var.pod_name}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "ftdv02-mgmt-ip-${var.pod_name}"
    subnet_id                     = azurerm_subnet.subnet_mgmt.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.41.3.11"
    public_ip_address_id          = azurerm_public_ip.ftdv02-mgmt-public-ip.id
  }
}

resource "azurerm_network_interface" "ftdv02-diag" {
  name                = "ftdv02-diag-${var.pod_name}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "ftdv02-diag-ip-${var.pod_name}"
    subnet_id                     = azurerm_subnet.subnet_diag.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.41.255.11"
  }
}

resource "azurerm_network_interface" "ftdv02-outside" {
  name                = "ftdv02-outside-${var.pod_name}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  enable_ip_forwarding = true

  ip_configuration {
    name                          = "ftdv02-outside-ip-${var.pod_name}"
    subnet_id                     = azurerm_subnet.subnet_outside.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.41.1.11"
    public_ip_address_id          = azurerm_public_ip.ftdv02-outside-public-ip.id
  }
}

resource "azurerm_network_interface" "ftdv02-inside" {
  name                = "ftdv02-inside-${var.pod_name}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  enable_ip_forwarding = true

  ip_configuration {
    name                          = "ftdv02-inside-ip-${var.pod_name}"
    subnet_id                     = azurerm_subnet.subnet_inside.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.41.2.11"
  }
}

###################################################
#### Associate Security Group with Interface
###################################################
resource "azurerm_network_interface_security_group_association" "association" {
  network_interface_id      = azurerm_network_interface.oobjmpbox-nic.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

resource "azurerm_network_interface_security_group_association" "association2" {
  network_interface_id      = azurerm_network_interface.jmpbox-nic.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

resource "azurerm_network_interface_security_group_association" "association3" {
  network_interface_id      = azurerm_network_interface.ftdv01-diag.id
  network_security_group_id = azurerm_network_security_group.allow_all.id
}

resource "azurerm_network_interface_security_group_association" "association4" {
  network_interface_id      = azurerm_network_interface.ftdv01-mgmt.id
  network_security_group_id = azurerm_network_security_group.allow_all.id
}

resource "azurerm_network_interface_security_group_association" "association5" {
  network_interface_id      = azurerm_network_interface.ftdv01-outside.id
  network_security_group_id = azurerm_network_security_group.allow_all.id
}

resource "azurerm_network_interface_security_group_association" "association6" {
  network_interface_id      = azurerm_network_interface.ftdv01-inside.id
  network_security_group_id = azurerm_network_security_group.allow_all.id
}

resource "azurerm_network_interface_security_group_association" "association7" {
  network_interface_id      = azurerm_network_interface.ftdv02-diag.id
  network_security_group_id = azurerm_network_security_group.allow_all.id
}

resource "azurerm_network_interface_security_group_association" "association8" {
  network_interface_id      = azurerm_network_interface.ftdv02-mgmt.id
  network_security_group_id = azurerm_network_security_group.allow_all.id
}

resource "azurerm_network_interface_security_group_association" "association9" {
  network_interface_id      = azurerm_network_interface.ftdv02-outside.id
  network_security_group_id = azurerm_network_security_group.allow_all.id
}

resource "azurerm_network_interface_security_group_association" "association10" {
  network_interface_id      = azurerm_network_interface.ftdv02-inside.id
  network_security_group_id = azurerm_network_security_group.allow_all.id
}

resource "azurerm_network_interface_security_group_association" "association11" {
  network_interface_id      = azurerm_network_interface.linux-nic.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}
