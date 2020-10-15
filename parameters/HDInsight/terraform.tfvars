# ---------------------------------------------------------------------------------------------------------------------
# TERRAGRUNT CONFIGURATION
# This is the configuration for Terragrunt, a thin wrapper for Terraform that supports locking and enforces best
# practices: https://github.com/gruntwork-io/terragrunt
# ---------------------------------------------------------------------------------------------------------------------

terragrunt = {
  # Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
  # working directory, into a temporary folder, and execute your Terraform commands in that folder.
  terraform {
    source = "${path_relative_from_include()}/../../modules//HDInsight"
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

resource_group_name = "AZXRESGP013"


virtual_network_config_map = {
  "resource_group_name"  = "AZXRESGP001"
  "virtual_network_name" = "AZXVNET001"
  "hdi_subnet_name"      = "AZXSNET004HDI"
}

hdi_name_list = [
  
  "AZXKAFKAHDI001",
]



