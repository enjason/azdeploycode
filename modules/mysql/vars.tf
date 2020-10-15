variable "location" {
  description = "Specifies the supported Azure location where the resource exists."
  default     = "China North 2"
}

variable "environment" {
  description = "The name of DEV/PROD environment."
}

variable "project" {
  description = "The name of project."
  default     = "AZCLOUD"
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the MySQL Server."
}

variable "mysql_name_list" {
  type        = "list"
  description = "The list of MySQL Server name"
}

variable "mysql_admin_password" {
  description = "The Password associated with the administrator_login for the MySQL Server."
}

variable "mysql_capacity_map" {
  type        = "map"
  description = "The map between MySQL Server name and capacity"
  default     = {}
}

variable "mysql_tier_map" {
  type        = "map"
  description = "The map between MySQL Server name and tier. Possible values are Basic, GeneralPurpose, and MemoryOptimized"
  default     = {}
}

variable "mysql_family_map" {
  type        = "map"
  description = "The map between MySQL Server name and the family of hardware Gen4 or Gen5"
  default     = {}
}

variable "mysql_storage_map" {
  type        = "map"
  description = "The map between MySQL Server name and max storage in MB allowed for a server."
  default     = {}
}
