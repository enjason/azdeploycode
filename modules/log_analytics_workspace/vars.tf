variable "location" {
  description = "Specifies the supported Azure location where the resource exists."
  default     = "China East 2"
}

variable "environment" {
  description = "The name of dev/prod environment."
}

variable "project" {
  description = "The name of project."
  default     = "azcloud"
}

variable "resource_group_name" {
  description = "The name of the resource group in which the Log Analytics workspace is created."
}

variable "log_analytics_workspace_name" {
  description = "Specifies the name of the Log Analytics Workspace."
}

variable "retention_in_days" {
  description = "The workspace data retention in days."
  default     = 180
}

variable "sku" {
  description = "Specifies the Sku of the Log Analytics Workspace."
  default     = "Standalone"
}
