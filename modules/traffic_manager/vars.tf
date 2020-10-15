# virtual machine variables
variable "resource_group_name" {
  description = "The name of the resource group"
}

# Environment related variables
variable "environment" {
  description = "The name of dev/prod environment."
}

variable "project" {
  description = "The name of project."
  default     = "azcloud"
}

variable "public_ip_resource_group" {
  description = "The name of the resource group in which to create the public ip."
}

variable "traffic_manager_config_map" {
  type        = "map"
  description = "The map of traffic manager name and its PIP name."
}
