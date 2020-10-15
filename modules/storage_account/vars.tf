# virtual machine variables
variable "resource_group_name" {
  description = "The name of the resource group in which to create the storage account. "
}

variable "location" {
  description = "Specifies the supported Azure location where the resource exists."
  default     = "China North 2"
}

# Environment related variables
variable "environment" {
  description = "The name of dev/prod environment."
}

variable "project" {
  description = "The name of project."
  default     = "azcloud"
}

variable "storage_account_name_prefix" {
  description = "Prefix of storage account name."
}


variable "storage_accounts_count" {
  description = "How many storage accounts we need."
}

