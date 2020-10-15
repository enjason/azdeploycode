output "web_appgw" {
  value = "${azurerm_application_gateway.web_appgw.http_listener }"
}

output "apigw_appgw" {
  value = "${azurerm_application_gateway.apigw_appgw.http_listener }"
}

output "oneapi_appgw" {
  value = "${azurerm_application_gateway.oneapi_appgw.http_listener }"
}
