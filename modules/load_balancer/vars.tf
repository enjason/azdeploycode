# ----------------------
# Basic variables
variable "environment" {
  description = "The name of dev/prod environment."
}

variable "project" {
  description = "The name of project."
  default     = "azcloud"
}

variable "location" {
  description = "The location where lb is created."
  default     = "China North 2"
}

variable "resource_group_name" {
  description = "The name of resource group in where lb is created."
}

variable "virtual_network_config_map" {
  type        = "map"
  description = "The map that contains virtual network config data"

  default = {
    "resource_group_name"  = "AZXRESGP001"
    "virtual_network_name" = "AZXVNET001"
    "mgmt_subnet_name"     = "AZXSNET001MGMT"
    "app_subnet_name"      = "AZXSNET002App"
    "web_subnet_name"      = "AZXSNET004Web"
    "db_subnet_name"       = "AZXSNET005DB"
  }
}

variable "vm_resource_group_name" {
  description = "Specifies the name of the Resource Group in which the Virtual Machine should exist."
}

# ----------------------
# elasticsearch load balancer related vars
variable "es_lb_config" {
  type        = "map"
  description = "Configuration of Azure Load Balancer for elasticsearch proxy"

  default = {
    "name"            = "AZXINTLB005"
    "frontend_port"   = 9200
    "backend_port"    = 9200
    "http_probe_path" = "/"
  }
}

variable "es_lb_backend_vm" {
  type        = "list"
  description = "Backenv VM name for es_lb"

  default = ["AZXVMSI001", "AZXVMSI002"]
}

#----------------------
