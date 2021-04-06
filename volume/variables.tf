#NETAPP VOLUME REQUIRED

variable "netapp_vol_name" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "account_name" {
  type = string
}

variable "pool_name" {
  type = string
}

variable "volume_path" {
  type = string
}

variable "service_level" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "storage_quota_in_gb" {
  type = number
}

variable "snapshot_policy_name" {
  type    = string
  default = null
}

#NETAPP VOLUME OPTIONAL

variable "protocols" {
  type    = list(string)
  default = null
}

variable "export_policy_rules" {
  type = list(object({
    rule_index        = string
    allowed_clients   = list(string)
    protocols_enabled = list(string)
    unix_read_only    = bool
    unix_read_write   = bool
  }))
  default = [
    {
      rule_index        = "1"
      allowed_clients   = []
      protocols_enabled = []
      unix_read_only    = null
      unix_read_write   = null
    }
  ]
}

#tags
variable "environment" {
  type = map(any)
  default = {
    tags = {}
  }
  description = "Global tags"
}

variable "tags" {
  type        = map(any)
  default     = {}
  description = "Specific tags"
}

###-------------------- ALERTS

variable "action_group_id" {
  type    = string
  default = null
}

variable "enable_metric_alert" {
  type    = bool
  default = true
}

variable "enable_dynamic_metric_alert" {
  type    = bool
  default = true
}

variable "criteria" {
  type = map(object({
    name             = string
    enabled          = bool
    description      = string
    frequency        = string
    severity         = number
    window_size      = string
    metric_namespace = string
    metric_name      = string
    aggregation      = string
    operator         = string
    threshold        = number
  }))
  default = {
    "REPLICATION" = {
      name             = "REPLICATION"
      enabled          = false
      description      = "NetApp: Volume replication unhealthy"
      frequency        = "PT1M"
      severity         = 1
      window_size      = "PT5M"
      metric_namespace = "Microsoft.NetApp/netAppAccounts/capacityPools/volumes"
      metric_name      = "XregionReplicationHealthy"
      aggregation      = "Average"
      operator         = "LessThanOrEqual"
      threshold        = 0
    },
    "VOLUMESPACE80" = {
      name             = "VOLUMESPACE80"
      enabled          = true
      description      = "NetApp: Volume space utilization over 80%"
      frequency        = "PT1M"
      severity         = 2
      window_size      = "PT5M"
      metric_namespace = "Microsoft.NetApp/netAppAccounts/capacityPools/volumes"
      metric_name      = "VolumeConsumedSizePercentage"
      aggregation      = "Average"
      operator         = "GreaterThan"
      threshold        = 80
    },
    # "REPLICATIONTIME" = {
    #   metric_namespace = "Microsoft.NetApp/netAppAccounts/capacityPools/volumes"
    #   metric_name      = "XregionReplicationLastTransferDuration"
    #   aggregation      = "Average"
    #   operator         = "GreaterThan" ??
    #   threshold        = ??
    #   description      = "NetApp: Volume replication duration over TBD"
    #   severity         = 2
    # },
    # "REPLICATIONLAG" = {
    #   metric_namespace = "Microsoft.NetApp/netAppAccounts/capacityPools/volumes"
    #   metric_name      = "XregionReplicationLagTime"
    #   aggregation      = "Average"
    #   operator         = "GreaterThan"??
    #   threshold        = ??
    #   description      = "NetApp: Volume replication lag time over TBD"
    #   severity         = 2
    # },
    "ReadIOPS80" = {
      name             = "ReadIOPS80"
      enabled          = true
      description      = "NetApp: Volume Read IOPS over 80 percent"
      frequency        = "PT1M"
      severity         = 2
      window_size      = "PT5M"
      metric_namespace = "Microsoft.NetApp/netAppAccounts/capacityPools/volumes"
      metric_name      = "ReadIops"
      aggregation      = "Average"
      operator         = "GreaterThan"
      threshold        = 0
    },
    "WriteIOPS80" = {
      name             = "WriteIOPS80"
      enabled          = true
      description      = "NetApp: Volume Write IOPS over 80 percent"
      frequency        = "PT1M"
      severity         = 2
      window_size      = "PT5M"
      metric_namespace = "Microsoft.NetApp/netAppAccounts/capacityPools/volumes"
      metric_name      = "WriteIops"
      aggregation      = "Average"
      operator         = "GreaterThan"
      threshold        = 0
    },
  }
}


variable "dimensions" {
  type    = map(any)
  default = {}
}

variable "dynamic_criteria" {
  type = map(object({
    name                     = string
    enabled                  = bool
    description              = string
    frequency                = string
    severity                 = number
    window_size              = string
    metric_namespace         = string
    metric_name              = string
    aggregation              = string
    operator                 = string
    alert_sensitivity        = string
    evaluation_total_count   = number
    evaluation_failure_count = number
  }))
  default = {
    "ReadLATENCYLOW" = {
      name                     = "ReadLATENCYLOW"
      enabled                  = true
      description              = "NetApp: Volume Read Latency higher than usually"
      frequency                = "PT5M"
      severity                 = 2
      window_size              = "PT30M"
      metric_namespace         = "Microsoft.NetApp/netAppAccounts/capacityPools/volumes"
      metric_name              = "AverageReadLatency"
      aggregation              = "Average"
      operator                 = "GreaterThan"
      alert_sensitivity        = "Low"
      evaluation_total_count   = 4
      evaluation_failure_count = 4
    },
    "WriteLATENCYLOW" = {
      name                     = "WriteLATENCYLOW"
      enabled                  = true
      description              = "NetApp: Volume Write Latency higher than usually"
      frequency                = "PT5M"
      severity                 = 2
      window_size              = "PT30M"
      metric_namespace         = "Microsoft.NetApp/netAppAccounts/capacityPools/volumes"
      metric_name              = "AverageWriteLatency"
      aggregation              = "Average"
      operator                 = "GreaterThan"
      alert_sensitivity        = "Low"
      evaluation_total_count   = 4
      evaluation_failure_count = 4
    },
  }
}

#OPTIONAL

variable "auto_mitigate" {
  type    = bool
  default = true
}
