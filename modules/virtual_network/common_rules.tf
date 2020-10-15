# Common security rules for every subnet

resource "azurerm_network_security_rule" "SSHJump22" {
  count                       = "${length(var.network_security_group_config_map)}"
  name                        = "SSHJump22"
  description                 = "Linux jump Server"
  protocol                    = "TCP"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  access                      = "Allow"
  priority                    = 104
  direction                   = "Inbound"
  resource_group_name         = "${var.resource_group_name}"
  network_security_group_name = "${element(values(var.network_security_group_config_map), count.index)}"
  depends_on                  = ["azurerm_network_security_group.web_nsg", "azurerm_network_security_group.app_nsg", "azurerm_network_security_group.appgw_nsg", "azurerm_network_security_group.redis_nsg", "azurerm_network_security_group.db_nsg"]
}



resource "azurerm_network_security_rule" "slb80" {
  count                       = "${length(var.network_security_group_config_map)}"
  name                        = "slb80"
  description                 = "SLB probe"
  protocol                    = "TCP"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "AzureLoadBalancer"
  destination_address_prefix  = "*"
  access                      = "Allow"
  priority                    = 107
  direction                   = "Inbound"
  resource_group_name         = "${var.resource_group_name}"
  network_security_group_name = "${element(values(var.network_security_group_config_map), count.index)}"
  depends_on                  = ["azurerm_network_security_group.web_nsg", "azurerm_network_security_group.app_nsg", "azurerm_network_security_group.appgw_nsg", "azurerm_network_security_group.redis_nsg", "azurerm_network_security_group.db_nsg"]
}

resource "azurerm_network_security_rule" "OTRSSH22" {
  count                       = "${length(var.network_security_group_config_map)}"
  name                        = "OTRSSH22"
  description                 = "SSH Login"
  protocol                    = "TCP"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "${local.app_subnet_cidr}"
  destination_address_prefix  = "*"
  access                      = "Allow"
  priority                    = 180
  direction                   = "Inbound"
  resource_group_name         = "${var.resource_group_name}"
  network_security_group_name = "${element(values(var.network_security_group_config_map), count.index)}"
  depends_on                  = ["azurerm_network_security_group.web_nsg", "azurerm_network_security_group.app_nsg", "azurerm_network_security_group.appgw_nsg", "azurerm_network_security_group.redis_nsg", "azurerm_network_security_group.db_nsg"]
}

resource "azurerm_network_security_rule" "DenyFA2A" {
  count                       = "${length(var.network_security_group_config_map)}"
  name                        = "DenyFA2A"
  description                 = "Disable all traffic"
  protocol                    = "TCP"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  access                      = "Deny"
  priority                    = 200
  direction                   = "Inbound"
  resource_group_name         = "${var.resource_group_name}"
  network_security_group_name = "${element(values(var.network_security_group_config_map), count.index)}"
  depends_on                  = ["azurerm_network_security_group.web_nsg", "azurerm_network_security_group.app_nsg", "azurerm_network_security_group.appgw_nsg", "azurerm_network_security_group.redis_nsg", "azurerm_network_security_group.db_nsg"]
}
