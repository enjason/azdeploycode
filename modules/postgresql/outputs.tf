output "postgresql" {
  value = ["${azurerm_postgresql_server.postgresql.*.fqdn}"]
}
