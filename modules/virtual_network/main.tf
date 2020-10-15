provider "azurerm" {
  environment = "china"
  version     = "1.37.0"
}

terraform {
  # The configuration for this backend will be filled in by Terragrunt
  backend "azurerm" {}

  required_version = "~> 0.11"
}

# Caculate subnet cidr address space by cidrsubnet function
locals {
  appgw_subnet_cidr = "${cidrsubnet(lookup(var.virtual_network_config_map, "address_space"), 2, 0)}"
  web_subnet_cidr   = "${cidrsubnet(lookup(var.virtual_network_config_map, "address_space"), 3, 2)}"
  db_subnet_cidr    = "${cidrsubnet(lookup(var.virtual_network_config_map, "address_space"), 4, 7)}"
  app_subnet_cidr   = "${cidrsubnet(lookup(var.virtual_network_config_map, "address_space"), 2, 2)}"
  hdi_subnet_cidr   = "${cidrsubnet(lookup(var.virtual_network_config_map, "address_space"), 3, 2)}"
}

data "azurerm_resource_group" "virtual_network_resource_group" {
  name = "${var.resource_group_name}"
}

resource "azurerm_network_security_group" "appgw_nsg" {
  name                = "${lookup(var.network_security_group_config_map, "appgw_subnet")}"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"

  tags = {
    project     = "${var.project}"
    environment = "${var.environment}"
  }
}



resource "azurerm_virtual_network" "virtual_network" {
  name                = "${var.virtual_network_name}"
  location            = "${data.azurerm_resource_group.virtual_network_resource_group.location}"
  resource_group_name = "${data.azurerm_resource_group.virtual_network_resource_group.name}"

  address_space = ["${lookup(var.virtual_network_config_map, "address_space")}"]
  dns_servers   = "${list(lookup(var.virtual_network_config_map, "dns_server"))}"

  # Web Subnet
  subnet {
    name           = "${lookup(var.virtual_network_config_map, "web_subnet_name")}"
    address_prefix = "${local.web_subnet_cidr}"
  }

  # App Subnet
  subnet {
    name           = "${lookup(var.virtual_network_config_map, "app_subnet_name")}"
    address_prefix = "${local.app_subnet_cidr}"
  }

  # APPGW Subnet
  subnet {
    name           = "${lookup(var.virtual_network_config_map, "appgw_subnet_name")}"
    address_prefix = "${local.appgw_subnet_cidr}"
    security_group = "${azurerm_network_security_group.appgw_nsg.id}"
  }

  # DB Subnet
  subnet {
    name           = "${lookup(var.virtual_network_config_map, "db_subnet_name")}"
    address_prefix = "${local.db_subnet_cidr}"
  }

  # hdi Subnet
  subnet {
    name           = "${lookup(var.virtual_network_config_map, "hdi_subnet_name")}"
    address_prefix = "${local.hdi_subnet_cidr}"
  }

  tags = {
    project     = "${var.project}"
    environment = "${var.environment}"
  }
}
