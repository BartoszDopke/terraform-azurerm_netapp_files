#name convention

variable "subscription_code" {
  type = string
}

variable "location_short" {
  type = string
}

variable "project_name" {
  type = string
}

variable "resource_id" {
  type = string
}


#NETAPP POOL REQUIRED

variable "netapp_pool_name" {
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

variable "service_level" {
  type = string
}

variable "size_in_tb" {
  type = number
}


#tags
variable "tags" {
  type = map
}
