provider "azurerm" {
  environment = "china"
  version     = "1.25.0"
}

terraform {
  # The configuration for this backend will be filled in by Terragrunt
  backend "azurerm" {}

  required_version = "~> 0.11"
}

data "azurerm_resource_group" "adf_resource_group" {
  name = "${var.resource_group_name}"
}


resource "azurerm_data_factory" "adf" {
  name                = "${var.adf_name}"
  location            = "${var.location}"
  resource_group_name = "${data.azurerm_resource_group.adf_resource_group.name}"


  tags = {
    project     = "${var.project}"
    environment = "${var.environment}"
  }

}