variable "location" {
  description = "Specifies the supported Azure location where the resource exists."
  default     = "China North 2"
}

variable "environment" {
  description = "The name of OTR/OTR+ environment."
}

variable "project" {
  description = "The name of project."
  default     = "OTR"
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the MsSQL Server."
}

variable "mssql_name01" {
  description = "The list of MsSQL Server name"
}

variable "mssql_name02" {
  description = "The list of MsSQL Server name"
}

variable "mssql_admin_password" {
  description = "The Password associated with the administrator_login for the MsSQL Server."
}
