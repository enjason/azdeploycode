provider "azurerm" {
  environment = "china"
  version     = "1.37.0"
}

terraform {
  # The configuration for this backend will be filled in by Terragrunt
  backend "azurerm" {}

  required_version = "~> 0.11"
}

data "azurerm_resource_group" "keyvault_rg" {
  name = "${var.resource_group_name}"
}



resource "azurerm_key_vault" "keyvault" {
  name                            = "${var.keyvault_name}"
  location                        = "${data.azurerm_resource_group.keyvault_rg.location}"
  resource_group_name             = "${data.azurerm_resource_group.keyvault_rg.name}"
  enabled_for_disk_encryption     = true
  enabled_for_template_deployment = true
  tenant_id                       = "********************************"

  sku {
    name = "${var.sku_name}"
  }

  access_policy {
    tenant_id = "********************************"
    object_id = "${var.read_secret_ad_application_id}"

    secret_permissions = [
      "set",
      "get",
      "delete",
    ]
    key_permissions = [
      "create",
      "get",
      "delete",
      "update"
    ]
  }

# Ignore currect access policy
  lifecycle {
    ignore_changes = [
      "access_policy",
    ]
  }
  tags = {
    project     = "${var.project}"
    environment = "${var.environment}"
  }
}



resource "azurerm_key_vault_access_policy" "read_secret" {
  key_vault_id = "${azurerm_key_vault.keyvault.id}"
  tenant_id    = "********************************"
  object_id    = "********************************"

  secret_permissions = [
    "get",
  ]

  key_permissions = [
    "get",
    "list",
    "UnwrapKey"
  ]

}



resource "azurerm_key_vault_secret" "secrets" {
  count        = "${length(var.secrets_name_list)}"
  name         = "${element(var.secrets_name_list, count.index)}"
  value        = "${lookup(var.secrets_map, element(var.secrets_name_list, count.index))}"
  key_vault_id = "${azurerm_key_vault.keyvault.id}"

  tags = {
    project     = "${var.project}"
    environment = "${var.environment}"
  }
}


resource "azurerm_key_vault_key" "keys01" {
  count        = "${length(var.keys_name_list)}"
  name         = "${element(var.keys_name_list, count.index)}"
  key_vault_id = "${azurerm_key_vault.keyvault.id}"
  key_type     = "RSA"
  key_size     = 2048

  key_opts = [
    "decrypt",
    "encrypt",
    "sign",
    "unwrapKey",
    "verify",
    "wrapKey",
  ]

  tags = {
    project     = "${var.project}"
    environment = "${var.environment}"
  }
}