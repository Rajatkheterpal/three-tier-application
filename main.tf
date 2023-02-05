# Create Network stack for Azure 

module "network" {
  source              = "./modules/network"
  name_prefix         = var.generic_vars.prefix
  resource_group_name = var.resource_group_name
  location            = var.location
  address_space       = var.address_space
  tags                = var.tags
}

# Create Linux VM for Azure 

module "linux_vm" {
  for_each             = toset(var.vm_name)
  source               = "./modules/linux"
  name                 = each.value
  prefix               = var.generic_vars.prefix
  resource_group_name  = module.network.resource_group_name
  location             = module.network.resource_group_location
  subnet_id            = module.network.subnet_id
  network_interface_id = module.network.network_interface_id
  size                 = var.size
  admin_username       = var.admin_username
  admin_password       = random_password.vmpasswd[each.key].result
  tags                 = var.tags
}

# Create MISQL for Azure 

module "misql" {
  source              = "./modules/db"
  generic_vars_db     = var.generic_vars_db
  resource_group_name = module.network.resource_group_name
  location            = module.network.resource_group_location
  subnet_id           = module.network.db_subnet_id
  admin_username      = var.admin_username
  admin_password      = random_password.mi_sql.result
  tags                = var.tags
}

# Create Azure KeyVault 

module "key_vault" {
  source                     = "./modules/key_vault"
  kv_name                    = var.kv_name
  resource_group_name        = module.network.resource_group_name
  soft_delete_retention_days = 7
  location                   = module.network.resource_group_location
  sku_name                   = var.sku_name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  object_id                  = data.azurerm_client_config.current.object_id
  tags                       = var.tags
}