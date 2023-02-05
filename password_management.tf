# VM Password Management
resource "random_password" "vmpasswd" {
  for_each = toset(var.vm_name)
  length   = 16
  special  = true
}

resource "azurerm_key_vault_secret" "web" {
  for_each     = toset(var.vm_name)
  name         = "${each.value}-kv"
  value        = random_password.vmpasswd[each.key].result
  key_vault_id = module.key_vault.key_vault_id
}

# MI_SQL Password Management
resource "random_password" "mi_sql" {
  length  = 16
  special = true
}

resource "azurerm_key_vault_secret" "db" {
  name         = "mi-sql-password"
  value        = random_password.mi_sql.result
  key_vault_id = module.key_vault.key_vault_id
}