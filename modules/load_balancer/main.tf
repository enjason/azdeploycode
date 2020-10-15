provider "azurerm" {
  environment = "china"
  version     = "1.25.0"
}

terraform {
  backend "azurerm" {}

  required_version = "~> 0.11"
}

# ------------------------
data "azurerm_resource_group" "azlb" {
  name = "${var.resource_group_name}"
}
