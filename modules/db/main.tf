# Manages a Microsoft SQL Azure Managed Instance.
resource "azurerm_mssql_managed_instance" "sqldb" {
  name                         = var.generic_vars_db.name
  resource_group_name          = var.resource_group_name
  location                     = var.location
  license_type                 = var.generic_vars_db.license_type
  sku_name                     = var.generic_vars_db.sku_name
  vcores                       = var.generic_vars_db.vcores
  storage_size_in_gb           = var.generic_vars_db.storage_size_in_gb
  storage_account_type         = var.generic_vars_db.storage_account_type
  administrator_login          = var.admin_username
  administrator_login_password = var.admin_password
  subnet_id                    = var.subnet_id
}