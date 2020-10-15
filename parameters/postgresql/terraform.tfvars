# ---------------------------------------------------------------------------------------------------------------------
# TERRAGRUNT CONFIGURATION
# This is the configuration for Terragrunt, a thin wrapper for Terraform that supports locking and enforces best
# practices: https://github.com/gruntwork-io/terragrunt
# ---------------------------------------------------------------------------------------------------------------------

terragrunt = {
  # Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
  # working directory, into a temporary folder, and execute your Terraform commands in that folder.
  terraform {
    source = "${path_relative_from_include()}/../../modules//postgresql"
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

resource_group_name = "AZXRESGP011"

postgresql_name_list = [
  "azxpostgresql001",
]

postgresql_tier_map = {
  "azxpostgresql001" = "GeneralPurpose",

}

postgresql_family_map = {
  "azxpostgresql001" = "Gen5",


}

postgresql_capacity_map =  {
  "azxpostgresql001" = 32,

}

postgresql_storage_map = {
  "azxpostgresql001" = 1024,

}
