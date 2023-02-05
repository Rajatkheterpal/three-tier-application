<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.6.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.6.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.4.3 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_key_vault"></a> [key\_vault](#module\_key\_vault) | ./modules/key_vault | n/a |
| <a name="module_linux_vm"></a> [linux\_vm](#module\_linux\_vm) | ./modules/linux | n/a |
| <a name="module_misql"></a> [misql](#module\_misql) | ./modules/db | n/a |
| <a name="module_network"></a> [network](#module\_network) | ./modules/network | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_key_vault_secret.db](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.web](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [random_password.mi_sql](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [random_password.vmpasswd](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_address_space"></a> [address\_space](#input\_address\_space) | address\_space | `list(string)` | n/a | yes |
| <a name="input_admin_username"></a> [admin\_username](#input\_admin\_username) | n/a | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment to which resources are being deployed | `string` | `"dev"` | no |
| <a name="input_generic_vars"></a> [generic\_vars](#input\_generic\_vars) | General variables for creating infrastructure | `any` | n/a | yes |
| <a name="input_generic_vars_db"></a> [generic\_vars\_db](#input\_generic\_vars\_db) | General variables for creating misql infrastructure | `any` | n/a | yes |
| <a name="input_kv_name"></a> [kv\_name](#input\_kv\_name) | Name of the Azure Key Vault | `string` | `"kv-d-tf01"` | no |
| <a name="input_location"></a> [location](#input\_location) | The geo location to which resources are being deployed | `string` | `"East US"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Name of the Application Resource Group | `string` | `"rg-d-tf-linux"` | no |
| <a name="input_size"></a> [size](#input\_size) | Size of the VM | `string` | `"Standard_B1s"` | no |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | n/a | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of the tags to use on the resources that are deployed with this module. | `map(string)` | <pre>{<br>  "environment": "dev"<br>}</pre> | no |
| <a name="input_vm_name"></a> [vm\_name](#input\_vm\_name) | Name of the VM | `list(string)` | <pre>[<br>  "linux-1",<br>  "linux-2"<br>]</pre> | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->