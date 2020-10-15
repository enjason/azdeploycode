provider "azurerm" {
  environment = "china"
  version     = "1.25.0"
}

terraform {
  # The configuration for this backend will be filled in by Terragrunt
  backend "azurerm" {}

  required_version = "~> 0.11"
}

data "azurerm_resource_group" "resource_group" {
  name = "${var.resource_group_name}"
}

resource "azurerm_storage_account" "vm_diagnostics_storage_account" {
  name                = "${format("%s%02d", var.storage_account_name_prefix, 9)}"
  resource_group_name = "${data.azurerm_resource_group.resource_group.name}"

  location                  = "${var.location}"
  account_kind              = "StorageV2"
  account_tier              = "Standard"
  account_replication_type  = "LRS"
  enable_https_traffic_only = true

  tags = {
    project     = "${var.project}"
    environment = "${var.environment}"
  }
}

resource "azurerm_storage_account" "appgw_diagnostics_storage_account" {
  name                = "${format("%s%02d", var.storage_account_name_prefix, 10)}"
  resource_group_name = "${data.azurerm_resource_group.resource_group.name}"

  location                  = "${var.location}"
  account_kind              = "StorageV2"
  account_tier              = "Standard"
  account_replication_type  = "LRS"
  enable_https_traffic_only = true

  tags = {
    project     = "${var.project}"
    environment = "${var.environment}"
  }
}

resource "azurerm_storage_account" "HDInsight" {
  name                = "${format("%s%02d", var.storage_account_name_prefix, 11 )}"
  resource_group_name = "${data.azurerm_resource_group.resource_group.name}"

  location                  = "${var.location}"
  account_kind              = "Storage"
  account_tier              = "Standard"
  account_replication_type  = "${var.environment == "prod" ? "GRS": "LRS"}"
  enable_https_traffic_only = true

  tags = {
    project     = "${var.project}"
    environment = "${var.environment}"
  }
}

resource "azurerm_storage_account" "storage_accounts" {
  count               = "${var.storage_accounts_count}"
  name                = "${format("%s%02d", var.storage_account_name_prefix, 12 + count.index)}"
  resource_group_name = "${data.azurerm_resource_group.resource_group.name}"

  location                  = "${var.location}"
  account_kind              = "StorageV2"
  account_tier              = "Standard"
  account_replication_type  = "${var.environment == "prod" ? "GRS": "LRS"}"
  enable_https_traffic_only = true

  tags = {
    project     = "${var.project}"
    environment = "${var.environment}"
  }
}

