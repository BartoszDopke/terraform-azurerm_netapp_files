#NETAPP ACCOUNT REQUIRED

variable "netapp_account_name" {
  type = string
}

variable "resource_group_name" {
  type = string
}

#SNAPSHOT POLICY

variable "snapshot_policy_name" {
  type    = string
  default = "DefaultSnapVol"
}

variable "snapshot_policy_parameters" {
  type    = string
  default = null
}

variable "snapshot_policy_type" {
  type    = string
  default = null
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
