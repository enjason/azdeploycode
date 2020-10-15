# ---------------------------------------------------------------------------------------------------------------------
# TERRAGRUNT CONFIGURATION
# This is the configuration for Terragrunt, a thin wrapper for Terraform that supports locking and enforces best
# practices: https://github.com/gruntwork-io/terragrunt
# ---------------------------------------------------------------------------------------------------------------------

terragrunt = {
  # Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
  # working directory, into a temporary folder, and execute your Terraform commands in that folder.
  terraform {
    source = "${path_relative_from_include()}/../../modules//load_balancer"
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

environment = "dev"

project = "azcloud"

resource_group_name = "AZXRESGP006"

location = "China North 2"

## virtual network
virtual_network_config_map = {
  "resource_group_name"  = "AZXRESGP001"
  "virtual_network_name" = "AZXVNET002"
  "web_subnet_name"      = "AZXSNET001Web"
}

# Virtual machines
vm_resource_group_name = "AZXRESGP003"

# ES load balancer
es_lb_config = {
  "name"            = "AZXINTLB002"
  "frontend_port"   = 9200
  "backend_port"    = 9200
  "http_probe_path" = ""
}

es_lb_backend_vm = ["AZXVMSA101"]