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
  description = "The name of the resource group in which to create the Redis instance."
}

variable "redis_capacity_map" {
  type        = "map"
  description = "The size of the Redis cache to deploy."
}

variable "redis_family_map" {
  type        = "map"
  description = "The SKU family to use. Valid values are C and P, where C = Basic/Standard, P = Premium."
}

variable "redis_sku_map" {
  type        = "map"
  description = "The SKU of Redis to use"
}

variable "redis_list" {
  type        = "list"
  description = "List of redis instances"
}

variable "virtual_network_config_map" {
  type        = "map"
  description = "The map that contains virtual network config data"

  default = {
    "resource_group_name"  = "AZXRESGP001"
    "virtual_network_name" = "AZXVNET001"
    "db_subnet_name"       = "AZXSNET003DB"
  }
}
