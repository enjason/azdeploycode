output "integration_lb" {
  value = "${azurerm_lb.integration_lb.private_ip_address }"
}

output "k8s_lb" {
  value = "${azurerm_lb.k8s_lb.*.private_ip_address }"
}

output "es_lb" {
  value = "${azurerm_lb.es_lb.private_ip_address}"
}

output "mongo_lb" {
  value = "${azurerm_lb.mongo_lb.private_ip_address }"
}
