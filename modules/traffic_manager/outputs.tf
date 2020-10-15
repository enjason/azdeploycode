output "traffic_manager" {
  value = "${azurerm_traffic_manager_profile.traffic_manager_profiles.*.fqdn}"
}
