# Load Balancer Security Group Rules
resource "azurerm_network_security_group" "lb-nsg" {
  name                = "${var.name_prefix}-lb-nsg"
  resource_group_name = azurerm_resource_group.application.name
  location            = azurerm_resource_group.application.location
  tags                = var.tags

  security_rule {
    name                       = "allow-lb-inbound"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "10.0.0.0/16"
  }
  security_rule {
    name                       = "allow-lb-inbound"
    priority                   = 200
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "10.0.0.0/16"
    destination_address_prefix = "*"
  }
}

# Web Security Group 
resource "azurerm_network_security_group" "nsg" {
  name                = "${var.name_prefix}-web-nsg"
  resource_group_name = azurerm_resource_group.application.name
  location            = azurerm_resource_group.application.location
  tags                = var.tags

  security_rule {
    name                       = "Allow_SSH"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "10.0.3.0/24"
    destination_address_prefix = "10.0.1.0/24"

  }
  security_rule {
    name                       = "allow-http"
    priority                   = 200
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "10.0.3.0/24"
    destination_address_prefix = "10.0.1.0/24"
  }
}

# DB Security Group

resource "azurerm_network_security_group" "db-nsg" {
  name                = "${var.name_prefix}-db-nsg"
  resource_group_name = azurerm_resource_group.application.name
  location            = azurerm_resource_group.application.location
  tags                = var.tags

  security_rule {
    name                       = "Allow_SQL"
    priority                   = 1000
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "1443"
    source_address_prefix      = "10.0.1.0/24"
    destination_address_prefix = "10.0.2.0/24"

  }
}

resource "azurerm_subnet_network_security_group_association" "server-subnet-nsg" {
  subnet_id                 = azurerm_subnet.internal_web.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

resource "azurerm_subnet_network_security_group_association" "db-subnet-nsg" {
  subnet_id                 = azurerm_subnet.db.id
  network_security_group_id = azurerm_network_security_group.db-nsg.id
}
resource "azurerm_subnet_network_security_group_association" "lb-subnet-nsg" {
  subnet_id                 = azurerm_subnet.lb.id
  network_security_group_id = azurerm_network_security_group.lb-nsg.id
}