provider "azurerm" {
  environment = "china"
  version     = "1.25.0"
}

terraform {
  # The configuration for this backend will be filled in by Terragrunt
  backend "azurerm" {}

  required_version = "~> 0.11"
}

data "azurerm_resource_group" "virtual_machines_resource_group" {
  name = "${var.resource_group_name}"
}

data "azurerm_subnet" "app_subnet" {
  name                 = "${lookup(var.virtual_network_config_map, "app_subnet_name")}"
  virtual_network_name = "${lookup(var.virtual_network_config_map, "virtual_network_name")}"
  resource_group_name  = "${lookup(var.virtual_network_config_map, "resource_group_name")}"
}