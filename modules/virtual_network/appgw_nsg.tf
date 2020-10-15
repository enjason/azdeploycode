# Security rules for appgw subnet
resource "azurerm_network_security_rule" "APPGWSubnetInt" {
  name                        = "SubnetInt"
  description                 = "Allow internal traffic"
  protocol                    = "TCP"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "${local.appgw_subnet_cidr}"
  destination_address_prefix  = "*"
  access                      = "Allow"
  priority                    = 150
  direction                   = "Inbound"
  resource_group_name         = "${var.resource_group_name}"
  network_security_group_name = "${azurerm_network_security_group.appgw_nsg.name}"
}

resource "azurerm_network_security_rule" "ExternalAcess" {
  name                        = "ExternalAcess"
  description                 = "Allow User access from Internet"
  protocol                    = "TCP"
  source_port_range           = "*"
  destination_port_ranges     = ["443", "8443"]
  source_address_prefix       = "Internet"
  destination_address_prefix  = "${local.appgw_subnet_cidr}"
  access                      = "Allow"
  priority                    = 151
  direction                   = "Inbound"
  resource_group_name         = "${var.resource_group_name}"
  network_security_group_name = "${azurerm_network_security_group.appgw_nsg.name}"
}

resource "azurerm_network_security_rule" "AppGWHealthProbe" {
  name                        = "AppGWHealthProbe"
  description                 = "Azure infrastructure communication"
  protocol                    = "TCP"
  source_port_range           = "*"
  destination_port_range      = "65503-65534"
  source_address_prefix       = "Internet"
  destination_address_prefix  = "${local.appgw_subnet_cidr}"
  access                      = "Allow"
  priority                    = 152
  direction                   = "Inbound"
  resource_group_name         = "${var.resource_group_name}"
  network_security_group_name = "${azurerm_network_security_group.appgw_nsg.name}"
}
