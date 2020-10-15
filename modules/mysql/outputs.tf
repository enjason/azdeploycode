output "mysql" {
  value = ["${azurerm_mysql_server.mysql.*.fqdn}"]
}
