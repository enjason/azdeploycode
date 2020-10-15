provider "azurerm" {
  environment = "china"
  version     = "1.36.0"
}

terraform {
  # The configuration for this backend will be filled in by Terragrunt
  backend "azurerm" {}

  required_version = "~> 0.11"
}

data "azurerm_resource_group" "hdi_resource_group" {
  name = "${var.resource_group_name}"
}



data "azurerm_subnet" "hdi_subnet" {
  name                 = "${lookup(var.virtual_network_config_map, "hdi_subnet_name")}"
  virtual_network_name = "${lookup(var.virtual_network_config_map, "virtual_network_name")}"
  resource_group_name  = "${lookup(var.virtual_network_config_map, "resource_group_name")}"
}

data "azurerm_virtual_network" "virtual_network" {
  name                 = "${lookup(var.virtual_network_config_map, "virtual_network_name")}"
  resource_group_name  = "${lookup(var.virtual_network_config_map, "resource_group_name")}"
}

resource "azurerm_storage_account" "example" {
  name                     = "storage_account_name"
  resource_group_name      = "AZXRESGP002"
  location                 = "${var.location}"
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "example" {
  name                  = "hdinsight"
  resource_group_name   = "AZXRESGP002"
  storage_account_name  = "${azurerm_storage_account.example.name}"
  container_access_type = "private"
}

resource "azurerm_hdinsight_kafka_cluster" "example" {
  count               = "${length(var.hdi_name_list)}"
  name                = "${element(var.hdi_name_list, count.index)}"
  location            = "${var.location}"
  resource_group_name = "${data.azurerm_resource_group.hdi_resource_group.name}"
  cluster_version     = "4.0"
  tier                = "Standard"

  component_version {
    kafka = "2.1"
  }

  gateway {
    enabled  = true
    username = "hdiadmin01"
    password = "1OkxQP!79tLmj"
  }

  storage_account {
    storage_container_id = "${azurerm_storage_container.example.id}"
    storage_account_key  = "${azurerm_storage_account.example.primary_access_key}"
    is_default           = true
  }

  roles {
    head_node {
      vm_size                 = "Standard_A4m_V2"
      username                = "sshadmin01"
      password                = "SHyBep#mPD18"
      virtual_network_id      = "${data.azurerm_virtual_network.virtual_network.id}"
      subnet_id               = "${data.azurerm_subnet.app_subnet.id}"
    }

    worker_node {
      vm_size                  = "Standard_A2m_V2"
      username                 = "sshadmin01"
      password                 = "SHyBep#mPD18"
      virtual_network_id       = "${data.azurerm_virtual_network.virtual_network.id}"
      subnet_id                = "${data.azurerm_subnet.app_subnet.id}"
      number_of_disks_per_node = 2
      target_instance_count    = 3
    }

    zookeeper_node {
      vm_size  = "Standard_A1_V2"
      username = "sshadmin01"
      password = "SHyBep#mPD18"
      virtual_network_id      = "${data.azurerm_virtual_network.virtual_network.id}"
      subnet_id               = "${data.azurerm_subnet.app_subnet.id}"
    }
  }

  tags = {
    project     = "${var.project}"
    environment = "${var.environment}"
  }
}

