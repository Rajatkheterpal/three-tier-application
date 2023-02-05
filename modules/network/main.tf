# Resource Group 
resource "azurerm_resource_group" "application" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

# Virtual network 
resource "azurerm_virtual_network" "vnet" {
  name                = "${var.name_prefix}-vnet"
  resource_group_name = azurerm_resource_group.application.name
  location            = azurerm_resource_group.application.location
  address_space       = var.address_space
  tags                = var.tags
}

# Subnets for the three tiers
resource "azurerm_subnet" "internal_web" {
  name                 = "${var.name_prefix}-app-subnet"
  resource_group_name  = azurerm_resource_group.application.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_subnet" "db" {
  name                 = "${var.name_prefix}-db-subnet"
  resource_group_name  = azurerm_resource_group.application.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_subnet" "lb" {
  name                 = "${var.name_prefix}-lb-subnet"
  resource_group_name  = azurerm_resource_group.application.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.3.0/24"]
}

# Create Load balancer and Public IP 

resource "azurerm_public_ip" "lb" {
  name                = "${var.name_prefix}-public-ip"
  resource_group_name = azurerm_resource_group.application.name
  location            = azurerm_resource_group.application.location
  allocation_method   = "Static"
}

resource "azurerm_lb" "lb" {
  name                = "${var.name_prefix}-lb"
  resource_group_name = azurerm_resource_group.application.name
  location            = azurerm_resource_group.application.location
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = "${var.name_prefix}-public"
    public_ip_address_id = azurerm_public_ip.lb.id
    subnet_id            = azurerm_subnet.lb.id
  }
}

# Create a backend pool
resource "azurerm_lb_backend_address_pool" "backend_pool" {
  name            = "${var.name_prefix}-backend-pool"
  loadbalancer_id = azurerm_lb.lb.id
}

resource "azurerm_network_interface" "nic" {
  name                = "${var.name_prefix}-nic"
  resource_group_name = azurerm_resource_group.application.name
  location            = azurerm_resource_group.application.location
  tags                = var.tags
  ip_configuration {
    name                          = "${var.name_prefix}-nic-ipconfig"
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.internal_web.id
  }
}

resource "azurerm_network_interface_backend_address_pool_association" "backend_pool" {
  network_interface_id    = azurerm_network_interface.nic.id
  ip_configuration_name   = "configuration1"
  backend_address_pool_id = azurerm_lb_backend_address_pool.backend_pool.id
}
# Create a load balancing rule
resource "azurerm_lb_rule" "rule" {
  name                           = "${var.name_prefix}-rule"
  loadbalancer_id                = azurerm_lb.lb.id
  frontend_port                  = 22
  backend_port                   = 22
  protocol                       = "Tcp"
  frontend_ip_configuration_name = "lb-frontend"
}