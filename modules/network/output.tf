output "resource_group_name" {
  value = azurerm_resource_group.application.name
}

output "resource_group_location" {
  value = azurerm_resource_group.application.location
}

output "subnet_id" {
  value = azurerm_subnet.internal_web.id
}

output "db_subnet_id" {
  value = azurerm_subnet.db.id
}

output "network_interface_id" {
  value = azurerm_network_interface.nic.id
}