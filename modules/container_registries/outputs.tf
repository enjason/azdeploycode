output "acr_address" {
  value = "${azurerm_container_registry.acr.login_server}"
}

# output "acr_admin_username" {
#   sensitive = true
#   value     = "${azurerm_container_registry.acr.admin_username}"
# }


# output "acr_admin_password" {
#   sensitive = true
#   value     = "${azurerm_container_registry.acr.admin_password}"
# }

