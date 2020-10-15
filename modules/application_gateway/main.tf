provider "azurerm" {
  environment = "china"
  version     = "1.30.0"
}

terraform {
  backend "azurerm" {}

  required_version = "~> 0.11"
}

# since these variables are re-used - a locals block makes this more maintainable
locals {
  backend_address_pool_name      = "backend"
  frontend_port_name             = "frontend-port"
  frontend_ip_configuration_name = "frontend-ip"
  http_setting_name              = "http-setting"
  listener_name                  = "https-listener"
  probe_name                     = "http-probe"
  request_routing_rule_name      = "http-rule"
  url_path_map_name              = "url-path-map"
  url_path_map_rule_name         = "url-path-rule"
}

data "azurerm_subnet" "appgw_subnet" {
  name                 = "${lookup(var.virtual_network_config_map, "appgw_subnet_name")}"
  virtual_network_name = "${lookup(var.virtual_network_config_map, "virtual_network_name")}"
  resource_group_name  = "${lookup(var.virtual_network_config_map, "resource_group_name")}"
}

data "azurerm_subnet" "app_subnet" {
  name                 = "${lookup(var.virtual_network_config_map, "app_subnet_name")}"
  virtual_network_name = "${lookup(var.virtual_network_config_map, "virtual_network_name")}"
  resource_group_name  = "${lookup(var.virtual_network_config_map, "resource_group_name")}"
}

data "azurerm_resource_group" "public_ip_resource_group" {
  name = "${var.public_ip_resource_group}"
}

data "azurerm_resource_group" "appgw_resource_group" {
  name = "${var.appgw_resource_group}"
}

data "azurerm_log_analytics_workspace" "log_analytics" {
  count               = "${length(var.log_analytics_config_map) == 0 ? 0 : 1}"
  name                = "${lookup(var.log_analytics_config_map, "log_analytics_name")}"
  resource_group_name = "${lookup(var.log_analytics_config_map, "resource_group_name")}"
}
