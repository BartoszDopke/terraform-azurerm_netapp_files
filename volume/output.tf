output "netapp_volume_name" {
  value = azurerm_netapp_volume.netapp_volume.name
}

output "netapp_volume_id" {
  value = azurerm_netapp_volume.netapp_volume.id
}

output "netapp_mount_ip_addresses" {
  value = azurerm_netapp_volume.netapp_volume.mount_ip_addresses
}

output "volume_path" {
  value = azurerm_netapp_volume.netapp_volume.volume_path
}

output "full_volume_path" {
  value = "${join(", ", azurerm_netapp_volume.netapp_volume.mount_ip_addresses)}:/${azurerm_netapp_volume.netapp_volume.volume_path}"
}
