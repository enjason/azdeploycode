# ---------------------------------------------------------------------------------------------------------------------
# TERRAGRUNT CONFIGURATION
# This is the configuration for Terragrunt, a thin wrapper for Terraform that supports locking and enforces best
# practices: https://github.com/gruntwork-io/terragrunt
# ---------------------------------------------------------------------------------------------------------------------

terragrunt = {
  # Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
  # working directory, into a temporary folder, and execute your Terraform commands in that folder.
  terraform {
    source = "${path_relative_from_include()}/../../modules//resource_group"
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

environment = "DEV  "

project = "AZCLOUD"

resource_groups = {
  "AZXRESGP001" = "Virtual Network"
  "AZXRESGP002" = "Storage Accounts"
  "AZXRESGP003" = "Virtual Machines"
  "AZXRESGP004" = "Public IP"
  "AZXRESGP005" = "Application Gateway"
  "AZXRESGP006" = "Load Balaner"
  "AZXRESGP007" = "Traffic Manager"
  "AZXRESGP008" = "Redis"
  "AZXRESGP009" = "MySQL"
  "AZXRESGP010" = "SQL"
  "AZXRESGP011" = "Postgresql"
  "AZXRESGP012" = "Logic_apps"
  "AZXRESGP013" = "Container_registry"
  "AZXRESGP014" = "HDInsight"
  "AZXRESGP015" = "Data factory"
  "AZXRESGP016" = "Keyvault"
  "AZXRESGP017" = "Log Analytics workspace"
}

resource_group_location = {
  "AZXRESGP015" = "China East 2"
  "AZXRESGP017" = "China East 2"
}
