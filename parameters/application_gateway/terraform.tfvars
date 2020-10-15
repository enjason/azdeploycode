# ---------------------------------------------------------------------------------------------------------------------
# TERRAGRUNT CONFIGURATION
# This is the configuration for Terragrunt, a thin wrapper for Terraform that supports locking and enforces best
# practices: https://github.com/gruntwork-io/terragrunt
# ---------------------------------------------------------------------------------------------------------------------

terragrunt = {
  # Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
  # working directory, into a temporary folder, and execute your Terraform commands in that folder.
  terraform {
    source = "${path_relative_from_include()}/../../modules//application_gateway"
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

appgw_resource_group = "AZXRESGP005"

public_ip_resource_group = "AZXRESGP004"

virtual_network_config_map = {
  "resource_group_name"  = "AZXRESGP001"
  "virtual_network_name" = "AZXVNET002"
  "appgw_subnet_name"    = "AZXSNET001APPGW"
  "app_subnet_name"      = "AZXSNET002App"
}

log_analytics_config_map = {
  "resource_group_name" = "AZXRESGP014"
  "log_analytics_name"  = "AZXOMS001"
}

# Web Application Gateway
web_appgw_config_map = {
  "name"         = "AZXAPPGW001"
  "pip_name"     = "AZXPUBIP001"
  "sku_name"     = "WAF_Medium"
  "sku_tier"     = "WAF"
  "sku_capacity" = "1"
  "probe_host"   = "azcloud.com.cn"
  "probe_path"   = "/healthz"
}

web_appgw_backend_pool = ["192.168.1.74", "192.168.1.75"]

web_appgw_pfx_file = "azcloud.com.pfx"

