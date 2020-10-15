variable "resource_groups" {
  description = "The Map of the resource group names and its corresponding service"
  type        = "map"
}

variable "resource_group_location" {
  type        = "map"
  description = "The location where the resource group should be created."

  default = {}
}

variable "environment" {
  description = "The name of DEV/PROD environment."
}

variable "project" {
  description = "The name of project."
  default     = "AZCLOUD"
}
