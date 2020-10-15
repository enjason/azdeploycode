variable "location" {
  description = "The Azure region where the Application Gateway should exist."
  default     = "China North 2"
}

variable "environment" {
  description = "The name of OTR/OTR+ environment."
}

variable "project" {
  description = "The name of project."
  default     = "OTR"
}

variable "appgw_resource_group" {
  description = "The name of the resource group in which to the Application Gateway should exist."
}

variable "public_ip_resource_group" {
  description = "The name of the resource group in which to create the public ip."
}

variable "ssl_certificate_password" {
  description = "Password for the pfx file specified in data."
}

variable "virtual_network_config_map" {
  type        = "map"
  description = "The map that contains virtual network config data"

  default = {
    "resource_group_name"  = "DOTRMCNINFRESGP001"
    "virtual_network_name" = "DOTRMCNINFVNET001"
    "app_subnet_name"      = "DOTRMCNINFSNET002App"
    "appgw_subnet_name"    = "DOTRMCNINFSNET003APPGW"
    "web_subnet_name"      = "DOTRMCNINFSNET004Web"
  }
}

variable "log_analytics_config_map" {
  type        = "map"
  description = "The map that contains log analytics workspace config data"
  default     = {}
}

# Web Application Gateway
variable "web_appgw_config_map" {
  type        = "map"
  description = "The map that contains Web Application Gateway config data"

  default = {
    "name"         = "DOTRMCNINFAPPGW001"
    "pip_name"     = "DOTRMCNINFPUBIP001"
    "sku_name"     = "WAF_Medium"
    "sku_tier"     = "WAF"
    "sku_capacity" = "2"
  }
}

variable "web_appgw_backend_pool" {
  type        = "list"
  description = "A list of IP Addresses which should be part of the Backend Address Pool."
  default     = ["172.21.4.200", "172.21.4.201"]
}

variable "web_appgw_pfx_file" {
  description = "PFX file name for Web Application Gateway"
}

# ADCC Application Gateway
variable "apigw_appgw_config_map" {
  type        = "map"
  description = "The map that contains Web Application Gateway config data"

  default = {
    "name"         = "DOTRMCNINFAPPGW002"
    "sku_name"     = "Standard_Medium"
    "sku_tier"     = "Standard"
    "sku_capacity" = "2"
  }
}

variable "apigw_appgw_backend_pool" {
  type        = "list"
  description = "A list of IP Addresses which should be part of the Backend Address Pool."
  default     = ["172.21.4.200", "172.21.4.201"]
}

variable "apigw_appgw_pfx_file" {
  description = "PFX file name for APIGW Application Gateway"
}

# OneAPI Application Gateway
variable "oneapi_appgw_config_map" {
  type        = "map"
  description = "The map that contains OneAPI Application Gateway config data"

  default = {
    "name"         = "DOTRMCNINFAPPGW003"
    "pip_name"     = "DOTRMCNINFPUBIP003"
    "sku_name"     = "WAF_Medium"
    "sku_tier"     = "WAF"
    "sku_capacity" = "2"
  }
}

variable "oneapi_appgw_pfx_file" {
  description = "PFX file name for OneAPI Application Gateway"
}

variable "oneapi_appgw_backend_pool" {
  type        = "list"
  description = "A list of IP Addresses which should be part of the Backend Address Pool."
  default     = ["172.21.4.200", "172.21.4.201"]
}

# GoCD Application Gateway
variable "gocd_appgw_config_map" {
  type        = "map"
  description = "The map that contains GoCD Gateway config data"

  default = {
    "name"         = "DOTRMCNINFAPPGW003"
    "pip_name"     = "DOTRMCNINFPUBIP003"
    "sku_name"     = "WAF_Medium"
    "sku_tier"     = "WAF"
    "sku_capacity" = "2"
  }
}

variable "gocd_appgw_pfx_file" {
  description = "PFX file name for GoCD Application Gateway"
  default     = "int.otr.mercedes-benz.com.cn.pfx"
}

variable "gocd_appgw_backend_pool" {
  type        = "list"
  description = "A list of IP Addresses which should be part of the Backend Address Pool."
  default     = ["172.21.4.81"]
}

variable "nexus_appgw_backend_pool" {
  type        = "list"
  description = "A list of IP Addresses which should be part of the Backend Address Pool."
  default     = ["172.21.4.76"]
}

# Piwik Application Gateway
variable "piwik_appgw_config_map" {
  type        = "map"
  description = "The map that contains Piwik Application Gateway config data"

  default = {
    "name"         = "DOTRMCNINFAPPGW001"
    "pip_name"     = "DOTRMCNINFPUBIP003"
    "sku_name"     = "WAF_Medium"
    "sku_tier"     = "WAF"
    "sku_capacity" = "2"
  }
}

variable "piwik_appgw_backend_pool" {
  type        = "list"
  description = "A list of IP Addresses which should be part of the Backend Address Pool."
  default     = ["172.21.4.200", "172.21.4.201"]
}

variable "piwik_appgw_pfx_file" {
  description = "PFX file name for Piwik Application Gateway"
  default     = "piwik.otr.mercedes-benz.com.cn.pfx"
}

# Management Application Gateway(Kibana, Grafana, K8S Dashboard, etc)
variable "mgmt_appgw_config_map" {
  type        = "map"
  description = "The map that contains mgmt Application Gateway config data"

  default = {
    "name"         = "DOTRMCNINFAPPGW004"
    "pip_name"     = "DOTRMCNINFPUBIP004"
    "sku_name"     = "WAF_Medium"
    "sku_tier"     = "WAF"
    "sku_capacity" = "2"
  }
}

variable "mgmt_appgw_pfx_file" {
  description = "PFX file name for Management Application Gateway"
}

variable "appdynamic_mgmt_appgw_backend_pool" {
  type        = "list"
  description = "A list of IP Addresses which should be part of the Backend Address Pool."
  default     = ["172.21.4.200"]
}

variable "kibana_mgmt_appgw_backend_pool" {
  type        = "list"
  description = "A list of IP Addresses which should be part of the Backend Address Pool."
  default     = ["172.21.4.201"]
}
