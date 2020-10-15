variable "location" {
  description = "Specifies the supported Azure location where the resource exists."
  default     = "China North 2"
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the Container Registry."
}

variable "environment" {
  description = "The name of OTR environment."
}

variable "project" {
  description = "The name of project."
  default     = "azcloud"
}

variable "container_registry_name" {
  description = "Specifies the name of the Container Registry."
}

variable "acr_replication" {
  description = "A list of Azure locations where the container registry should be geo-replicated."
  default     = ["China East 2"]
}
