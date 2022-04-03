# Create internal load balancer
resource "azurerm_lb" "ILB" {
  name                = "ILB-${var.pod_name}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku = "Standard"
  
  frontend_ip_configuration {
    name = "ILB-ip-${var.pod_name}"
    private_ip_address_allocation = "static"
    private_ip_address = "10.41.2.4"
    subnet_id = azurerm_subnet.subnet_inside.id
  }
}

# Create lb probe
resource "azurerm_lb_probe" "ILB-probe-ssh" {
  loadbalancer_id = azurerm_lb.ILB.id
  name = "SSH-probe-${var.pod_name}"
  port = 22
  protocol = "Tcp"
}

resource "azurerm_lb_backend_address_pool" "ILB-FW" {
  name = "ILB-FW-${var.pod_name}"
  loadbalancer_id = azurerm_lb.ILB.id 
}

resource "azurerm_lb_backend_address_pool_address" "ILB-FW-FTDV01" {
  name = "FTDv01-${var.pod_name}"
  backend_address_pool_id = azurerm_lb_backend_address_pool.ILB-FW.id
  virtual_network_id = azurerm_virtual_network.vnet.id
  ip_address = "10.41.2.10"
}

resource "azurerm_lb_backend_address_pool_address" "ILB-FW-FTDV02" {
  name = "FTDv02-${var.pod_name}"
  backend_address_pool_id = azurerm_lb_backend_address_pool.ILB-FW.id
  virtual_network_id = azurerm_virtual_network.vnet.id
  ip_address = "10.41.2.11"
}

resource "azurerm_lb_rule" "ILB-FW" {
  loadbalancer_id = azurerm_lb.ILB.id
  name = "ILB-FW-${var.pod_name}"
  protocol = "All"
  frontend_port = 0
  backend_port = 0
  frontend_ip_configuration_name = "ILB-ip-${var.pod_name}"
  enable_floating_ip = false
  backend_address_pool_ids = [azurerm_lb_backend_address_pool.ILB-FW.id]
  probe_id = azurerm_lb_probe.ILB-probe-ssh.id
}