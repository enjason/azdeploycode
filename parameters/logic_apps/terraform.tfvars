# ---------------------------------------------------------------------------------------------------------------------
# TERRAGRUNT CONFIGURATION
# This is the configuration for Terragrunt, a thin wrapper for Terraform that supports locking and enforces best
# practices: https://github.com/gruntwork-io/terragrunt
# ---------------------------------------------------------------------------------------------------------------------

terragrunt = {
  # Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
  # working directory, into a temporary folder, and execute your Terraform commands in that folder.
  terraform {
    source = "${path_relative_from_include()}/../../modules//logic_apps"
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

resource_group = "AZXRESGP011"

environment = "DEV"

logic_app_name_prefix = "AZXLGAPP"

logic_apps_name_list = [
  "AccessMessage",

]

logic_apps_time_map = {
  "AccessMessage"                         = "{\"frequency\":\"Day\",\"interval\":1,\"timeZone\":\"UTC\",\"startTime\":\"2019-06-17T10:01:13Z\",\"schedule\":{\"hours\":[\"19\"],\"minutes\":[\"5\"]}}"

}

logic_apps_properties_map = {
  "AccessoryPackageStatisticsMessage"                             = "{\"type\":\"AccessMessageHandler\"}"
}


logic_apps_queue_map = {
  "AccessMessage"                   = "queue.scheduler.task"
}
