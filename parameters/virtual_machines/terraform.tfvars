# TERRAGRUNT CONFIGURATION
# This is the configuration for Terragrunt, a thin wrapper for Terraform that supports locking and enforces best
# practices: https://github.com/gruntwork-io/terragrunt
# ---------------------------------------------------------------------------------------------------------------------

terragrunt = {
  # Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
  # working directory, into a temporary folder, and execute your Terraform commands in that folder.
  terraform {
     source = "${path_relative_from_include()}/../../modules//virtual_machines"
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

resource_group_name = "AZXRESGP003"

admin_username = "vmadmin"

diagnostics_uri = "https://storageaccountblob.blob.core.chinacloudapi.cn"

## virtual network
virtual_network_config_map = {
  "resource_group_name"  = "AZXRESGP001"
  "virtual_network_name" = "AZXVNET001"
  "app_subnet_name"      = "AZXSNET004APP"
}

# Salt_Master_VMs
salt_vm_config_map = {
  "count"       = 2
  "size"        = "Standard_A1_v2"
  "name_prefix" = "AZXVMSA0"
}
