# ---------------------------------------------------------------------------------------------------------------------
# TERRAGRUNT CONFIGURATION
# This is the configuration for Terragrunt, a thin wrapper for Terraform that supports locking and enforces best
# practices: https://github.com/gruntwork-io/terragrunt
# ---------------------------------------------------------------------------------------------------------------------

terragrunt = {
  # Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
  # working directory, into a temporary folder, and execute your Terraform commands in that folder.
  terraform {
    source = "${path_relative_from_include()}/../../modules//mysql"
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

resource_group_name = "AZXRESGP012"

mysql_name_list = [
  "azxmysql001",
  "azxmysql002",
]

mysql_tier_map = {
  "azxmysql001" = "GeneralPurpose",
  "azxmysql002" = "GeneralPurpose",

}

mysql_family_map = {
  "azxmysql001" = "Gen5",
  "azxmysql002" = "Gen5",
}

mysql_capacity_map= {
  "azxmysql001" = "4",
  "azxmysql002" = "8",
}

mysql_storage_map = {

  "azxmysql001" = 102400,
  "azxmysql002" = 1024000,
}