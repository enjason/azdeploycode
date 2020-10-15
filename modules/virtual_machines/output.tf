
output "salt_vm," {
  value = "${azurerm_network_interface.salt_vm_network_interface.*.private_ip_address }"}