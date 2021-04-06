resource "azurerm_netapp_pool" "netapp_pool" {
  name                = var.netapp_pool_name
  account_name        = var.account_name
  resource_group_name = var.resource_group_name
  location            = var.location
  service_level       = var.service_level
  size_in_tb          = var.size_in_tb

  tags = var.tags
}
