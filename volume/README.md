## Requirements 

No requirements.

## Providers    

| Name | Version |
|------|---------|
| azurerm | n/a |
| null | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| account\_name | n/a | `string` | n/a | yes |
| action\_group\_id | n/a | `string` | `null` | no |
| auto\_mitigate | n/a | `bool` | `true` | no |
| criteria | n/a | <pre>map(object({<br>    name             = string<br>    enabled          = bool<br>    description      = string<br>    frequency        = string<br>    severity         = number<br>  
  window_size      = string<br>    metric_namespace = string<br>    metric_name      = string<br>    aggregation      = string<br>    operator         = string<br>    threshold        = number<br>  }))</pre> | <pre>{<br>  "REPLICATION": {<br>    "aggregation": "Average",<br>    "description": "NetApp: Volume replication unhealthy",<br>    "enabled": false,<br>    "frequency": "PT1M",<br>    "metric_name": "XregionReplicationHealthy",<br>    "metric_namespace": "Microsoft.NetApp/netAppAccounts/capacityPools/volumes",<br>    "name": "REPLICATION",<br>    "operator": "LessThanOrEqual",<br>    "severity": 1,<br>    "threshold": 0,<br>    "window_size": "PT5M"<br>  },<br>  "ReadIOPS80": {<br>    "aggregation": "Average",<br>    "description": "NetApp: Volume Read IOPS over 80 percent",<br>    "enabled": true,<br> 
   "frequency": "PT1M",<br>    "metric_name": "ReadIops",<br>    "metric_namespace": "Microsoft.NetApp/netAppAccounts/capacityPools/volumes",<br>    "name": "ReadIOPS80",<br>    "operator": "GreaterThan",<br>    "severity": 2,<br>    "threshold": 0,<br>    "window_size": "PT5M"<br>  },<br>  "VOLUMESPACE80": {<br>    "aggregation": "Average",<br>    "description": "NetApp: Volume space utilization over 80%",<br>    "enabled": true,<br>    "frequency": "PT1M",<br>    "metric_name": "VolumeConsumedSizePercentage",<br>    "metric_namespace": "Microsoft.NetApp/netAppAccounts/capacityPools/volumes",<br>    "name": "VOLUMESPACE80",<br>    "operator": "GreaterThan",<br>    "severity": 2,<br>    "threshold": 80,<br>    "window_size": "PT5M"<br>  },<br>  "WriteIOPS80": {<br>    "aggregation": "Average",<br>    "description": "NetApp: Volume Write IOPS over 80 percent",<br>    "enabled": true,<br>    "frequency": "PT1M",<br>    "metric_name": "WriteIops",<br>    "metric_namespace": "Microsoft.NetApp/netAppAccounts/capacityPools/volumes",<br>    "name": "WriteIOPS80",<br>    "operator": "GreaterThan",<br>    "severity": 2,<br>    "threshold": 0,<br>    "window_size": "PT5M"<br>  }<br>}</pre> | no |
| dimensions | n/a | `map(any)` | `{}` | no |
| dynamic\_criteria | n/a | <pre>map(object({<br>    name                     = string<br>    enabled                  = bool<br>    description              = string<br>    frequency                = string<br>    severity                 = number<br>    window_size              = string<br>    metric_namespace         = string<br>    metric_name              = string<br>    aggregation              = string<br>    operator                 = string<br>    alert_sensitivity        = string<br>    evaluation_total_count   = number<br>    evaluation_failure_count = number<br>  }))</pre> | <pre>{<br>  "ReadLATENCYLOW": {<br>    "aggregation": "Average",<br>    "alert_sensitivity": "Low",<br>    "description": "NetApp: Volume Read Latency higher than usually",<br>    "enabled": true,<br>    "evaluation_failure_count": 4,<br>    "evaluation_total_count": 4,<br>    "frequency": "PT5M",<br>    "metric_name": "AverageReadLatency",<br>    "metric_namespace": "Microsoft.NetApp/netAppAccounts/capacityPools/volumes",<br> 
   "name": "ReadLATENCYLOW",<br>    "operator": "GreaterThan",<br>    "severity": 2,<br>    "window_size": "PT30M"<br>  },<br>  "WriteLATENCYLOW": {<br>    "aggregation": "Average",<br>    "alert_sensitivity": "Low",<br>    "description": "NetApp: Volume Write Latency higher than usually",<br>    "enabled": true,<br>    "evaluation_failure_count": 4,<br>    "evaluation_total_count": 4,<br>    "frequency": "PT5M",<br>    "metric_name": "AverageWriteLatency",<br>    "metric_namespace": "Microsoft.NetApp/netAppAccounts/capacityPools/volumes",<br>    "name": "WriteLATENCYLOW",<br>    "operator": "GreaterThan",<br>    "severity": 2,<br>    "window_size": "PT30M"<br>  }<br>}</pre> | no |
| enable\_dynamic\_metric\_alert | n/a | `bool` | `true` | no |
| enable\_metric\_alert | n/a | `bool` | `true` | no |
| environment | Global tags | `map(any)` | <pre>{<br>  "tags": {}<br>}</pre> | no |
| export\_policy\_rules | n/a | <pre>list(object({<br>    rule_index        = string<br>    allowed_clients   = list(string)<br>    protocols_enabled = list(string)<br>    unix_read_only    = bool<br>    unix_read_write   = bool<br>  }))</pre> | <pre>[<br>  {<br>    "allowed_clients": [],<br>    "protocols_enabled": [],<br>    "rule_index": "1",<br>    "unix_read_only": null,<br>    "unix_read_write": null<br>  }<br>]</pre> | no |
| location | n/a | `string` | n/a | yes |
| netapp\_vol\_name | n/a | `string` | n/a | yes |
| pool\_name | n/a | `string` | n/a | yes |
| protocols | n/a | `list(string)` | `null` | no |
| resource\_group\_name | n/a | `string` | n/a | yes |
| service\_level | n/a | `string` | n/a | yes |
| snapshot\_policy\_name | n/a | `string` | `null` | no |
| storage\_quota\_in\_gb | n/a | `number` | n/a | yes |
| subnet\_id | n/a | `string` | n/a | yes |
| tags | Specific tags | `map(any)` | `{}` | no |
| volume\_path | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| full\_volume\_path | n/a |
| netapp\_mount\_ip\_addresses | n/a |
| netapp\_volume\_id | n/a |
| netapp\_volume\_name | n/a |
| volume\_path | n/a |
