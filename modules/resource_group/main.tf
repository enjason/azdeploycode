provider "azurerm" {
  environment = "china"
  version     = "1.25.0"
}

terraform {
  # The configuration for this backend will be filled in by Terragrunt
  backend "azurerm" {}

  required_version = "~> 0.11"
}

resource "azurerm_resource_group" "resource_groups" {
  count    = "${length(var.resource_groups)}"
  name     = "${element(keys(var.resource_groups), count.index)}"
  location = "${lookup(var.resource_group_location, element(keys(var.resource_groups), count.index), "China North 2")}"

  tags = {
    project       = "${var.project}"
    environment   = "${var.environment}"
    resource_type = "${element(values(var.resource_groups), count.index)}"
  }
}
