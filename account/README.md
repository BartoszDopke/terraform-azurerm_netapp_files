## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |
| <a name="provider_null"></a> [null](#provider\_null) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_netapp_account.netapp_account](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/netapp_account) | resource |
| [null_resource.snapshot_policy](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environment"></a> [environment](#input\_environment) | Global tags | `map(any)` | <pre>{<br>  "tags": {}<br>}</pre> | no |
| <a name="input_netapp_account_name"></a> [netapp\_account\_name](#input\_netapp\_account\_name) | n/a | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | n/a | `string` | n/a | yes |
| <a name="input_snapshot_policy_name"></a> [snapshot\_policy\_name](#input\_snapshot\_policy\_name) | n/a | `string` | `"DefaultSnapVol"` | no |
| <a name="input_snapshot_policy_parameters"></a> [snapshot\_policy\_parameters](#input\_snapshot\_policy\_parameters) | n/a | `string` | `null` | no |
| <a name="input_snapshot_policy_type"></a> [snapshot\_policy\_type](#input\_snapshot\_policy\_type) | n/a | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Specific tags | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_netapp_account_name"></a> [netapp\_account\_name](#output\_netapp\_account\_name) | n/a |
| <a name="output_snapshot_policy_name"></a> [snapshot\_policy\_name](#output\_snapshot\_policy\_name) | n/a |
