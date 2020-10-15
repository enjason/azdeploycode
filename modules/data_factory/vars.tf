variable "location" {
  description = "Specifies the supported Azure location where the resource exists."
  default     = "China North 2"
}

variable "environment" {
  description = "The name of DEV/PROD environment."
}

variable "project" {
  description = "The name of project."
  default     = "AZCLOUD  "
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the azure data factory."
}


variable "adf_name" {
  description = "The name of the adf name in which to create the adf."
}

