provider "azurerm" {
  environment = "china"
  version     = "1.36.0"
}

terraform {
  # The configuration for this backend will be filled in by Terragrunt
  backend "azurerm" {}

  required_version = "~> 0.11"
}

data "azurerm_resource_group" "redis_resource_group" {
  name = "${var.resource_group_name}"
}

resource "azurerm_redis_cache" "standard_redis" {
  count               = "${length(var.redis_list)}"
  name                = "${lower(element(var.redis_list, count.index))}"
  location            = "${var.location}"
  resource_group_name = "${data.azurerm_resource_group.redis_resource_group.name}"
  capacity            = "${lookup(var.redis_capacity_map, element(var.redis_list,count.index), 1)}"
  family              = "${lookup(var.redis_family_map, element(var.redis_list,count.index), "c")}"
  sku_name            = "${lookup(var.redis_sku_map, element(var.redis_list,count.index), "Standard")}"

  redis_configuration = {
    maxmemory_policy                = "volatile-lru"
    maxmemory_reserved              = 200
    maxfragmentationmemory_reserved = 300
  }

  tags = {
    project     = "${var.project}"
    environment = "${var.environment}"
  }
}
