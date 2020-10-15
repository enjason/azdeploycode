output "virtual_network" {
  value = "${azurerm_virtual_network.virtual_network.name}"
}

output "virtual_network_subnets" {
  value = "${azurerm_virtual_network.virtual_network.subnet}"
}
