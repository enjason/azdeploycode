provider "azurerm" {
  environment = "china"
  version     = "1.25.0"
}

terraform {
  # The configuration for this backend will be filled in by Terragrunt
  backend "azurerm" {}

  required_version = "~> 0.11"
}

data "azurerm_resource_group" "mysql_resource_group" {
  name = "${var.resource_group_name}"
}

resource "azurerm_mysql_server" "mysql" {
  count               = "${length(var.mysql_name_list)}"
  name                = "${element(var.mysql_name_list, count.index)}"
  location            = "${var.location}"
  resource_group_name = "${data.azurerm_resource_group.mysql_resource_group.name}"

  sku {
    name     = "${format("GP_%s_%s", lookup(var.mysql_family_map, element(var.mysql_name_list,count.index), "Gen5"), lookup(var.mysql_capacity_map, element(var.mysql_name_list,count.index), 4))}"
    capacity = "${lookup(var.mysql_capacity_map, element(var.mysql_name_list,count.index), 4)}"
    tier     = "${lookup(var.mysql_tier_map, element(var.mysql_name_list,count.index), "GeneralPurpose")}"
    family   = "${lookup(var.mysql_family_map, element(var.mysql_name_list,count.index), "Gen5")}"
  }

  storage_profile {
    storage_mb            = "${lookup(var.mysql_storage_map, element(var.mysql_name_list,count.index), 102400)}"
    backup_retention_days = "${var.environment == "prod" ? 35: 22}"
    geo_redundant_backup  = "Disabled"
  }

  administrator_login          = "OTRDBA"
  administrator_login_password = "${var.mysql_admin_password}"
  version                      = "5.7"
  ssl_enforcement              = "Enabled"

  tags = {
    project     = "${var.project}"
    environment = "${var.environment}"
  }
}

resource "azurerm_mysql_firewall_rule" "public_mysql_firewall_rule" {
  count               = "${var.environment == "prod" ? 0: length(var.mysql_name_list)}"
  name                = "All"
  resource_group_name = "${data.azurerm_resource_group.mysql_resource_group.name}"
  server_name         = "${element(azurerm_mysql_server.mysql.*.name, count.index)}"
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "0.0.0.0"
}

resource "azurerm_mysql_firewall_rule" "20200219_mysql_firewall_rule" {
  count               = "${var.environment == "prod" ? 0: length(var.mysql_name_list)}"
  name                = "2020"
  resource_group_name = "${data.azurerm_resource_group.mysql_resource_group.name}"
  server_name         = "${element(azurerm_mysql_server.mysql.*.name, count.index)}"
  start_ip_address    = "11.11.11.11"
  end_ip_address      = "11.11.11.12"
}