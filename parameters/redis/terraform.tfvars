# ---------------------------------------------------------------------------------------------------------------------
# TERRAGRUNT CONFIGURATION
# This is the configuration for Terragrunt, a thin wrapper for Terraform that supports locking and enforces best
# practices: https://github.com/gruntwork-io/terragrunt
# ---------------------------------------------------------------------------------------------------------------------

terragrunt = {
  # Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
  # working directory, into a temporary folder, and execute your Terraform commands in that folder.
  terraform {
    source = "${path_relative_from_include()}/../../modules//redis"
  }

  # Include all settings from the root terraform.tfvars file
  include = {
    path = "${find_in_parent_folders()}"
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# MODULE PARAMETERS
# These are the variables we have to pass in to use the module specified in the terragrunt configuration above
# ---------------------------------------------------------------------------------------------------------------------

environment = "DEV"

project = "AZCLOUD"

resource_group_name = "AZXRESGP008"

## virtual network
virtual_network_config_map = {
  "resource_group_name"  = "AZXRESGP001"
  "virtual_network_name" = "AZXVNET001"
  "db_subnet_name"    = "AZXSNET003DB"
}

redis_list = ["azxredis003", "azxredis004"]

sku_name = "Standard"

family = "C"

capacity = "1"
