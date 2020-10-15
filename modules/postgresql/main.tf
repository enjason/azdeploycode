provider "azurerm" {
  environment = "china"
  version     = "1.36.0"
}

terraform {
  # The configuration for this backend will be filled in by Terragrunt
  backend "azurerm" {}

  required_version = "~> 0.11"
}

data "azurerm_resource_group" "postgresql_resource_group" {
  name = "${var.resource_group_name}"
}

resource "azurerm_postgresql_server" "postgresql" {
  count               = "${length(var.postgresql_name_list)}"
  name                = "${element(var.postgresql_name_list, count.index)}"
  location            = "${var.location}"
  resource_group_name = "${data.azurerm_resource_group.postgresql_resource_group.name}"

  sku {
    name     = "${format("GP_%s_%s", lookup(var.postgresql_family_map, element(var.postgresql_name_list,count.index), "Gen5"), lookup(var.postgresql_capacity_map, element(var.postgresql_name_list,count.index), 4))}"
    capacity = "${lookup(var.postgresql_capacity_map, element(var.postgresql_name_list,count.index), 4)}"
    tier     = "${lookup(var.postgresql_tier_map, element(var.postgresql_name_list,count.index), "GeneralPurpose")}"
    family   = "${lookup(var.postgresql_family_map, element(var.postgresql_name_list,count.index), "Gen5")}"
  }

  storage_profile {
    storage_mb            = "${lookup(var.postgresql_storage_map, element(var.postgresql_name_list,count.index), 102400)}"
    backup_retention_days = "${var.environment == "prod" ? 35: 22}"
    geo_redundant_backup  = "Disabled"
  }

  administrator_login          = "OTRDBA"
  administrator_login_password = "${var.postgresql_admin_password}"
  version                      = "11"
  ssl_enforcement              = "Enabled"

  tags = {
    project     = "${var.project}"
    environment = "${var.environment}"
  }
}


resource "azurerm_postgresql_database" "postgresqldb" {
  name                = "iotrpsdb001"
  resource_group_name = "${data.azurerm_resource_group.postgresql_resource_group.name}"
  server_name         = "${element(azurerm_postgresql_server.postgresql.*.name, count.index)}"
  charset             = "UTF8"
  collation           = "English_United States.1252"
}



resource "azurerm_postgresql_firewall_rule" "public_postgresql_firewall_rule" {
  count               = "${var.environment == "prod" ? 0: length(var.postgresql_name_list)}"
  name                = "FromAzure"
  resource_group_name = "${data.azurerm_resource_group.postgresql_resource_group.name}"
  server_name         = "${element(azurerm_postgresql_server.postgresql.*.name, count.index)}"
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "0.0.0.0"
}
