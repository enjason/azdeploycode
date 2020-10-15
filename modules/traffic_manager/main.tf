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

data "azurerm_public_ip" "public_ips" {
  count               = "${length(var.traffic_manager_config_map)}"
  name                = "${element(values(var.traffic_manager_config_map), count.index)}"
  resource_group_name = "${var.public_ip_resource_group}"
}

resource "azurerm_traffic_manager_profile" "traffic_manager_profiles" {
  count                  = "${length(var.traffic_manager_config_map)}"
  name                   = "${element(keys(var.traffic_manager_config_map), count.index)}"
  resource_group_name    = "${data.azurerm_resource_group.resource_group.name}"
  traffic_routing_method = "Performance"

  dns_config {
    relative_name = "${element(keys(var.traffic_manager_config_map), count.index)}"
    ttl           = 300
  }

  monitor_config {
    protocol = "https"
    port     = 443
    path     = "/"
  }

  tags = {
    project     = "${var.project}"
    environment = "${var.environment}"
  }
}

resource "azurerm_traffic_manager_endpoint" "traffic_manager_endpoints" {
  count               = "${length(var.traffic_manager_config_map)}"
  name                = "${element(values(var.traffic_manager_config_map), count.index)}"
  resource_group_name = "${data.azurerm_resource_group.resource_group.name}"
  profile_name        = "${element(azurerm_traffic_manager_profile.traffic_manager_profiles.*.name, count.index)}"
  type                = "azureEndpoints"
  target_resource_id  = "${element(data.azurerm_public_ip.public_ips.*.id, count.index)}"
}
