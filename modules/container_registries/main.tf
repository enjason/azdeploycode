provider "azurerm" {
  environment = "china"
  version     = "1.25.0"
}

terraform {
  # The configuration for this backend will be filled in by Terragrunt
  backend "azurerm" {}

  required_version = "~> 0.11"
}

data "azurerm_resource_group" "rg" {
  name = "${var.resource_group_name}"
}

# Create Azure Container Registry
resource "azurerm_container_registry" "acr" {
  name                     = "${var.container_registry_name}"
  resource_group_name      = "${data.azurerm_resource_group.rg.name}"
  location                 = "${data.azurerm_resource_group.rg.location}"
  sku                      = "Premium"
  admin_enabled            = false

  tags = {
    project     = "${var.project}"
    environment = "${var.environment}"
  }
}
