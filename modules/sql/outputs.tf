output "mssql01" {
  value = ["${azurerm_sql_server.mssql01.id}"]
}

output "mssql02" {
  value = ["${azurerm_sql_server.mssql02.id}"]
}