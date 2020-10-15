variable "location" {
  description = "Specifies the supported Azure location where the resource exists."
  default     = "China North 2"
}

variable "environment" {
  description = "The name of dev/prod environment."
}

variable "project" {
  description = "The name of project."
  default     = "azcloud"
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the hdi."
}

variable "hdi_name_list" {
  type        = "list"
  description = "The list of hdi name"
}

variable "virtual_network_config_map" {
  type        = "map"
  description = "The map that contains virtual network config data"
}

