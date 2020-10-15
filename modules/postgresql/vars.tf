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
  description = "The name of the resource group in which to create the postgresql Server."
}

variable "postgresql_name_list" {
  type        = "list"
  description = "The list of postgresql Server name"
}


variable "postgresql_admin_password" {
  description = "The Password associated with the administrator_login for the postgresql Server."
}

variable "postgresql_capacity_map" {
  type        = "map"
  description = "The map between postgresql Server name and capacity"
  default     = {}
}

variable "postgresql_tier_map" {
  type        = "map"
  description = "The map between postgresql Server name and tier. Possible values are Basic, GeneralPurpose, and MemoryOptimized"
  default     = {}
}

variable "postgresql_family_map" {
  type        = "map"
  description = "The map between postgresql Server name and the family of hardware Gen4 or Gen5"
  default     = {}
}

variable "postgresql_storage_map" {
  type        = "map"
  description = "The map between postgresql Server name and max storage in MB allowed for a server."
  default     = {}
}
