data "azurerm_subscription" "current" {}

locals {
  iops_80         = format("%.0f", (var.storage_quota_in_gb * 1.6))
  allowed_clients = flatten([for i in var.export_policy_rules.*.allowed_clients : i])

  tags = {
    "Environment" = lookup(var.environment.tags, "Environment", "empty"),
    "Remark"      = lookup(var.environment.tags, "Remark", "empty")
  }
}

resource "azurerm_netapp_volume" "netapp_volume" {
  name                = var.netapp_vol_name
  resource_group_name = var.resource_group_name
  location            = var.location
  account_name        = var.account_name
  pool_name           = var.pool_name
  volume_path         = var.volume_path
  service_level       = var.service_level
  subnet_id           = var.subnet_id
  storage_quota_in_gb = var.storage_quota_in_gb
  protocols           = var.protocols

  dynamic "export_policy_rule" {
    for_each = var.export_policy_rules
    content {
      rule_index        = export_policy_rule.value.rule_index
      allowed_clients   = export_policy_rule.value.allowed_clients
      protocols_enabled = export_policy_rule.value.protocols_enabled
      unix_read_only    = export_policy_rule.value.unix_read_only
      unix_read_write   = export_policy_rule.value.unix_read_write
    }
  }

  tags = merge(local.tags, var.tags)
}

resource "null_resource" "data_protection" {
  depends_on = [azurerm_netapp_volume.netapp_volume]
  count      = var.snapshot_policy_name != null ? 1 : 0
  triggers = {
    always_check = timestamp()
  }

  provisioner "local-exec" {
    command     = <<EOT
      Write-Host "${var.netapp_vol_name} will be associated with ${var.snapshot_policy_name} soon!" 
      Invoke-AzRestMethod -Path "${data.azurerm_subscription.current.id}/resourceGroups/${var.resource_group_name}/providers/Microsoft.NetApp/netAppAccounts/${var.account_name}/capacityPools/${var.pool_name}/volumes/${var.netapp_vol_name}?api-version=2020-09-01" -Method PATCH -Payload '{"properties": { "dataProtection": { "snapshot": { "snapshotPolicyId": "${data.azurerm_subscription.current.id}/resourceGroups/${var.resource_group_name}/providers/Microsoft.NetApp/netAppAccounts/${var.account_name}/snapshotPolicies/${var.snapshot_policy_name}"}}}}'
    EOT
    interpreter = ["pwsh", "-Command"]
  }
}

resource "azurerm_monitor_metric_alert" "alert" {
  depends_on = [azurerm_netapp_volume.netapp_volume]

  for_each            = var.enable_metric_alert == true ? var.criteria : {}
  name                = "alert-${var.netapp_vol_name}-001-${each.value.name}"
  resource_group_name = var.resource_group_name
  scopes              = [azurerm_netapp_volume.netapp_volume.id]
  enabled             = each.value.enabled
  auto_mitigate       = var.auto_mitigate
  description         = each.value.description
  frequency           = each.value.frequency
  severity            = each.value.severity
  window_size         = each.value.window_size

  criteria {
    metric_namespace = each.value.metric_namespace
    metric_name      = each.value.metric_name
    aggregation      = each.value.aggregation
    operator         = each.value.operator
    threshold        = (each.value.name == "ReadIOPS80" || each.value.name == "WriteIOPS80") ? each.value.threshold + local.iops_80 : each.value.threshold
  }

  action {
    action_group_id = var.action_group_id
  }

  tags = local.tags
}

resource "azurerm_monitor_metric_alert" "dynamic_alert" {
  depends_on = [azurerm_netapp_volume.netapp_volume]

  for_each            = var.enable_dynamic_metric_alert == true ? var.dynamic_criteria : {}
  name                = "alert-${var.netapp_vol_name}-001-${each.value.name}"
  resource_group_name = var.resource_group_name
  scopes              = [azurerm_netapp_volume.netapp_volume.id]
  enabled             = each.value.enabled
  auto_mitigate       = var.auto_mitigate
  description         = each.value.description
  frequency           = each.value.frequency
  severity            = each.value.severity
  window_size         = each.value.window_size

  dynamic_criteria {
    metric_namespace         = each.value.metric_namespace
    metric_name              = each.value.metric_name
    aggregation              = each.value.aggregation
    operator                 = each.value.operator
    alert_sensitivity        = each.value.alert_sensitivity
    evaluation_total_count   = each.value.evaluation_total_count
    evaluation_failure_count = each.value.evaluation_failure_count
  }

  action {
    action_group_id = var.action_group_id
  }

  tags = local.tags
}
