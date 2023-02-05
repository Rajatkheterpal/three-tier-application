data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "kv" {
  name                        = var.kv_name
  location                    = var.location
  resource_group_name         = var.resource_group_name
  enabled_for_disk_encryption = true
  tenant_id                   = var.tenant_id
  soft_delete_retention_days  = var.soft_delete_retention_days
  tags                        = var.tags

  sku_name = var.sku_name

  access_policy {
    tenant_id = var.tenant_id
    object_id = var.object_id

    key_permissions = [
      "Get",
    ]

    secret_permissions = [
      "Set",
      "Get",
      "Delete"
    ]

    storage_permissions = [
      "Get",
      "Set"
    ]
  }
}

resource "azurerm_key_vault_key" "cmk" {
  name         = "cmk-key"
  key_vault_id = azurerm_key_vault.kv.id
  key_type     = "RSA"
  key_size     = 2048

  depends_on = [
    azurerm_key_vault_access_policy.user
  ]

  key_opts = [
    "decrypt",
    "encrypt",
    "sign",
    "unwrapKey",
    "verify",
    "wrapKey",
  ]
}

resource "azurerm_disk_encryption_set" "des" {
  name                = "des"
  resource_group_name = var.resource_group_name
  location            = var.location
  key_vault_key_id    = azurerm_key_vault_key.cmk.id

  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_key_vault_access_policy" "disk" {
  key_vault_id = azurerm_key_vault.kv.id

  tenant_id = azurerm_disk_encryption_set.des.identity.0.tenant_id
  object_id = azurerm_disk_encryption_set.des.identity.0.principal_id

  key_permissions = [
    "Create",
    "Delete",
    "Get",
    "Purge",
    "Recover",
    "Update",
    "List",
    "Decrypt",
    "Sign"
  ]
}

resource "azurerm_key_vault_access_policy" "user" {
  key_vault_id = azurerm_key_vault.kv.id

  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = data.azurerm_client_config.current.object_id

  key_permissions = [
    "Create",
    "Delete",
    "Get",
    "Purge",
    "Recover",
    "Update",
    "List",
    "Decrypt",
    "Sign"
  ]
}

resource "azurerm_role_assignment" "disk" {
  scope                = azurerm_key_vault.kv.id
  role_definition_name = "Key Vault Crypto Service Encryption User"
  principal_id         = azurerm_disk_encryption_set.des.identity.0.principal_id
}