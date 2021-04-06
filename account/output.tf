output "netapp_account_name" {
  value = azurerm_netapp_account.netapp_account.name
}

output "snapshot_policy_name" {
  value = local.snapshot_policy_name
}
