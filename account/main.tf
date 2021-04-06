locals {
  tags = {
    "Environment" = lookup(var.environment.tags, "Environment", "empty"),
    "Remark"      = lookup(var.environment.tags, "Remark", "empty")
  }

  snapshot_policy_type = var.snapshot_policy_type == "gold" ? "--daily-hour 1 --daily-minute 0 --daily-snapshots 30" : var.snapshot_policy_type == "standard" ? "--daily-hour 1 --daily-minute 0 --daily-snapshots 14" : var.snapshot_policy_parameters
  snapshot_policy_name = var.snapshot_policy_type == "gold" ? "${var.netapp_account_name}-GoldSnapVol-01" : var.snapshot_policy_type == "standard" ? "${var.netapp_account_name}-StandardSnapVol-01" : var.snapshot_policy_name
}


resource "azurerm_netapp_account" "netapp_account" {
  name                = var.netapp_account_name
  resource_group_name = var.resource_group_name
  location            = var.environment.location.name

  tags = merge(local.tags, var.tags)
}

resource "null_resource" "snapshot_policy" {
  depends_on = [azurerm_netapp_account.netapp_account]
  count      = var.snapshot_policy_type != null ? 1 : 0

  triggers = {
    type = var.snapshot_policy_type
  }
  provisioner "local-exec" {
    command     = <<EOT
          $snapshotPolicy = Get-AzNetAppFilesSnapshotPolicy -ResourceGroupName "${var.resource_group_name}" -AccountName "${var.netapp_account_name}" -Name "${local.snapshot_policy_name}" -ErrorAction SilentlyContinue
          
          if($snapshotPolicy -eq $null) {
            Write-Host "${local.snapshot_policy_name} will be created!"
            az netappfiles snapshot policy create -g "${var.resource_group_name}" --account-name "${var.netapp_account_name}" --snapshot-policy-name "${local.snapshot_policy_name}" -l "${var.environment.location.name}" --enabled true ${local.snapshot_policy_type}
          }
           else  {
            Write-Host "${local.snapshot_policy_name}-01 will be updated!"
            az netappfiles snapshot policy update -g "${var.resource_group_name}" --account-name "${var.netapp_account_name}" --snapshot-policy-name "${local.snapshot_policy_name}" -l "${var.environment.location.name}" --enabled true ${local.snapshot_policy_type}
          }

          if ("${var.snapshot_policy_type}" -eq "null") {
            if($snapshotPolicy -eq $null) {
            Write-Host "${local.snapshot_policy_name} does not exist!"
          }
           else  {
            Write-Host "${local.snapshot_policy_name} will be deleted!"
            az netappfiles snapshot policy delete -g "${var.resource_group_name}" --account-name "${var.netapp_account_name}" --snapshot-policy-name "${local.snapshot_policy_name}"
          }
        }
        EOT
    interpreter = ["pwsh", "-Command"]
  }
}
