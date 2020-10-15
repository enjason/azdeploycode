provider "azurerm" {
  environment = "china"
  version     = "1.37.0"
}

terraform {
  # The configuration for this backend will be filled in by Terragrunt
  backend "azurerm" {}

  required_version = "~> 0.11"
}


data "azurerm_resource_group" "mssql_resource_group" {
  name = "${var.resource_group_name}"
}

resource "azurerm_sql_server" "mssql01"{
  name                         = "${var.mssql_name01}"
  resource_group_name          = "${data.azurerm_resource_group.mssql_resource_group.name}"
  location                     = "${var.location}"
  version                      = "12.0"
  administrator_login          = "OTPDBA"
  administrator_login_password = "${var.mssql_admin_password}"


  tags = {
    project     = "${var.project}"
    environment = "${var.environment}"
  }
}

resource "azurerm_sql_server" "mssql02"{
  name                         = "${var.mssql_name02}"
  resource_group_name          = "${data.azurerm_resource_group.mssql_resource_group.name}"
  location                     = "${var.location}"
  version                      = "12.0"
  administrator_login          = "OTPDBA"
  administrator_login_password = "${var.mssql_admin_password}"


  tags = {
    project     = "${var.project}"
    environment = "${var.environment}"
  }
}
