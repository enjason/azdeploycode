provider "azurerm" {
  environment = "china"
  version     = "1.25.0"
}

terraform {
  # The configuration for this backend will be filled in by Terragrunt
  backend "azurerm" {}

  required_version = "~> 0.11"
}

# ------------------------
data "azurerm_resource_group" "logic_app_resource_group" {
  name = "${var.resource_group}"
}

resource "azurerm_logic_app_workflow" "logic_apps" {
  count               = "${length(var.logic_apps_name_list)}"
  name                = "${format("%s%03d", var.logic_app_name_prefix, count.index + 1)}"
  resource_group_name = "${data.azurerm_resource_group.logic_app_resource_group.name}"
  location            = "${var.location}"

  lifecycle {
    ignore_changes = [
      "parameters",
    ]
  }

  tags = {
    project     = "${var.project}"
    environment = "${var.environment}"
    app         = "${element(var.logic_apps_name_list, count.index)}"
  }
}

# ------------------------
