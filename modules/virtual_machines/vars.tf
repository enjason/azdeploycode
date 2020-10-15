# virtual machine variables
variable "resource_group_name" {
  description = "Specifies the name of the Resource Group in which the Virtual Machine should exist."
}

variable "location" {
  description = "Specifies the Azure Region where the Virtual Machine exists."
  default     = "China North2"
}

# Environment related variables
variable "environment" {
  description = "The name of UAT environment."
  default     = "DEV"
}

variable "project" {
  description = "The name of project."
  default     = "AZCLOUD"
}

variable "virtual_network_config_map" {
  type        = "map"
  description = "The map that contains virtual network config data"

}

# Common variables

variable "admin_username" {
  description = "Specifies the name of the local administrator account."
  default     = "itiadmin"
}

variable "admin_password" {
  description = "The password associated with the local administrator account."
}

variable "diagnostics_uri" {
  description = " The Storage Account's Blob Endpoint which should hold the virtual machine's diagnostic files."
}


# Salt Master 
variable "salt_vm_config_map" {
  type        = "map"
  description = "The map that Salt Master vm config data"

  default = {
    "count"       = 1
    "size"        = "Standard_A1_v2"
    "name_prefix" = "AZXVMSA0"
  }
}
