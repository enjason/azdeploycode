variable "environment" {
  description = "The name of DEV/PROD environment."
}

variable "project" {
  description = "The name of project."
  default     = "AZCLOUD"
}

variable "location" {
  description = "Specifies the supported Azure location where the Logic App Workflow exists."
  default     = "China North2"
}

variable "resource_group" {
  description = "The name of the Resource Group in which the Logic App Workflow should be created."
}

# ------------------------------------
variable "logic_app_name_prefix" {
  description = "Specifies the name's prefix of the Logic App Workflow"
}

variable "logic_apps_name_list" {
  type        = "list"
  description = "The map of Logic App's name to scheduler job name"
}

variable "logic_apps_time_map" {
  type        = "map"
  description = "The map of Logic App's name to scheduler time"
}

variable "logic_apps_properties_map" {
  type        = "map"
  description = "The map of Logic App's name to scheduler properties"
}

variable "logic_apps_queue_map" {
  type        = "map"
  description = "The map of Logic App's name to queue's name that the scheduler connected to"
}
