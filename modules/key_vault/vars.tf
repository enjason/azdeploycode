variable "location" {
  description = "Specifies the supported Azure location where the resource exists."
  default     = "China North 2"
}

variable "environment" {
  description = "The name of dev/prod environment."
}

variable "project" {
  description = "The name of project."
  default     = "azlcoud"
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the keyvault."
}

variable "sku_name" {
  description = "The SKU of keyvault to use"
  default     = "standard"
}

variable "keyvault_name" {
  description = "The name of keyvault"
}

variable "read_secret_ad_application_id" {
  default     = ""
  description = "The object ID of service principal in the Azure AD tenant for reading vault secret."
}



variable "secrets_name_list" {
  type        = "list"
  description = "List of KeyVault secret names"

  default = [
    "secretName",
  ]
}

variable "keys_name_list" {
  type        = "list"
  description = "List of KeyVault secret names"

  default = [
    "secretName",
  ]
}

variable "secrets_map" {
  type        = "map"
  description = "Map of KeyVault secrets"

  # default = {
  #   "secretName" = "secretValue"
  # }
}

