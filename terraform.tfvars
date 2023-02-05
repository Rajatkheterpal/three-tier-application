vm_name             = ["linux-1", "linux-2"]
resource_group_name = "rg-d-tf-linux"
location            = "East US"
environment         = "dev"
size                = "Standard_B1s"
address_space       = ["10.0.0.0/16"]
admin_username      = "azure_user"
generic_vars = {
  prefix = "tf"
}
kv_name = "kv-d-tf01"
tags = {
  environment = "dev"
}

sku_name = "standard"
generic_vars_db = {
  name                 = "mi_sql"
  license_type         = "BasePrice"
  sku_name             = "GP_Gen5"
  storage_size_in_gb   = 32
  vcores               = 4
  storage_account_type = "LRS"
  administrator_login  = "azure_user"
}