provider "azurerm" {
  environment = "china"
  version     = "1.25.0"
}

terraform {
  # The configuration for this backend will be filled in by Terragrunt
  backend "azurerm" {}

  required_version = "~> 0.11"
}

data "azurerm_resource_group" "log_analytics_resource_group" {
  name = "${var.resource_group_name}"
}

resource "azurerm_log_analytics_workspace" "log_analytics_workspace" {
  name                = "${var.log_analytics_workspace_name}"
  location            = "${var.location}"
  resource_group_name = "${data.azurerm_resource_group.log_analytics_resource_group.name}"
  sku                 = "${var.sku}"
  retention_in_days   = "${var.retention_in_days}"

  tags = {
    project     = "${var.project}"
    environment = "${var.environment}"
  }
}
