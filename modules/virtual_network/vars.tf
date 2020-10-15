# virtual network variables
variable "resource_group_name" {
  description = "The name of the resource group in which to create the virtual network."
}

variable "location" {
  description = "The location/region where the virtual network is created. Changing this forces a new resource to be created."
  default     = "China North 2"
}

variable "virtual_network_name" {
  description = "The name of the virtual network. Changing this forces a new resource to be created."
}

variable "environment" {
  description = "The name of dev/prod environment."
}

variable "project" {
  description = "The name of project."
  default     = "azcloud"
}

variable "virtual_network_config_map" {
  type        = "map"
  description = "The map that contains virtual network config data"

  default = {
    "address_space"     = "192.168.1.0/24"
    "dns_server"        = "192.168.1.16"
    "appgw_subnet_name" = "AZXSNET001APPGW"
    "web_subnet_name"   = "AZXSNET002Web"
    "db_subnet_name"    = "AZXSNET003DB"
    "app_subnet_name"   = "AZXSNET004App"
    "hdi_subnet_name"   = "AZXSNET005HDI"
  }
}

variable "network_security_group_config_map" {
  type        = "map"
  description = "The map that contains network security group config data"

  default = {
    "appgw_subnet" = "AZXNSG001APPGW"
  }
}
