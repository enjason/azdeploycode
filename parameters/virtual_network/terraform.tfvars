# ---------------------------------------------------------------------------------------------------------------------
# TERRAGRUNT CONFIGURATION
# This is the configuration for Terragrunt, a thin wrapper for Terraform that supports locking and enforces best
# practices: https://github.com/gruntwork-io/terragrunt
# ---------------------------------------------------------------------------------------------------------------------

terragrunt = {
  # Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
  # working directory, into a temporary folder, and execute your Terraform commands in that folder.
  terraform {
    source = "${path_relative_from_include()}/../../modules//virtual_network"
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

resource_group_name = "AZXRESGP001"

virtual_network_name = "AZXVNET001"

virtual_network_config_map = {
  "address_space"     = "192.168.1.0/24"
  "dns_server"        = "192.168.1.16"
  "appgw_subnet_name" = "AZXSNET001APPGW"
  "web_subnet_name"   = "AZXSNET002Web"
  "db_subnet_name"    = "AZXSNET003DB"
  "app_subnet_name"   = "AZXSNET004App"
  "hdi_subnet_name"   = "AZXSNET005HDI"
 }

network_security_group_config_map = {
  "appgw_subnet" = "AZXNSG001APPGW"
}
