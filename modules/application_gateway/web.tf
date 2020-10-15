resource "azurerm_public_ip" "web_appgw_public_ip" {
  name                = "${lookup(var.web_appgw_config_map, "pip_name")}"
  resource_group_name = "${data.azurerm_resource_group.public_ip_resource_group.name}"
  location            = "${var.location}"
  sku                 = "Basic"
  allocation_method   = "Dynamic"

  tags = {
    project     = "${var.project}"
    environment = "${var.environment}"
  }
}

resource "azurerm_application_gateway" "web_appgw" {
  name                = "${lookup(var.web_appgw_config_map, "name")}"
  resource_group_name = "${data.azurerm_resource_group.appgw_resource_group.name}"
  location            = "${var.location}"

  sku {
    name     = "${lookup(var.web_appgw_config_map, "sku_name")}"
    tier     = "${lookup(var.web_appgw_config_map, "sku_tier")}"
    capacity = "${lookup(var.web_appgw_config_map, "sku_capacity")}"
  }

  waf_configuration {
    enabled                  = true
    firewall_mode            = "Prevention"
    rule_set_type            = "OWASP"
    rule_set_version         = "3.0"
    file_upload_limit_mb     = "50"
    request_body_check       = true
    max_request_body_size_kb = 128

    disabled_rule_group {
      rule_group_name = "REQUEST-931-APPLICATION-ATTACK-RFI"

      rules = [
        931100,
        931110,
        931120,
      ]
    }
  }

  gateway_ip_configuration {
    name      = "gateway-ip-configuration"
    subnet_id = "${data.azurerm_subnet.appgw_subnet.id}"
  }

  frontend_ip_configuration {
    name                 = "${local.frontend_ip_configuration_name}"
    public_ip_address_id = "${azurerm_public_ip.web_appgw_public_ip.id}"
  }

  frontend_port {
    name = "${local.frontend_port_name}"
    port = 443
  }

  http_listener {
    name                           = "${local.listener_name}"
    frontend_ip_configuration_name = "${local.frontend_ip_configuration_name}"
    frontend_port_name             = "${local.frontend_port_name}"
    ssl_certificate_name           = "${format("%s.otr", var.environment)}"
    protocol                       = "Https"
  }

  ssl_policy {
    policy_type = "Predefined"
    policy_name = "AppGwSslPolicy20170401"
  }

  ssl_certificate {
    name     = "${format("%s.azcloud", var.environment)}"
    data     = "${base64encode(file("certificates/${var.web_appgw_pfx_file}"))}"
    password = "${var.ssl_certificate_password}"
  }

  backend_address_pool {
    name         = "${local.backend_address_pool_name}"
    ip_addresses = "${var.web_appgw_backend_pool}"
  }

  probe {
    name                = "${local.probe_name}"
    protocol            = "Http"
    path                = "${lookup(var.web_appgw_config_map, "probe_path", "/")}"
    host                = "${lookup(var.web_appgw_config_map, "probe_host")}"
    interval            = 300
    timeout             = 30
    unhealthy_threshold = 3
  }

  backend_http_settings {
    name                  = "${local.http_setting_name}"
    cookie_based_affinity = "Disabled"
    protocol              = "Http"
    port                  = 80
    request_timeout       = 300
    probe_name            = "${local.probe_name}"
  }

  request_routing_rule {
    name                       = "${local.request_routing_rule_name}"
    rule_type                  = "Basic"
    http_listener_name         = "${local.listener_name}"
    backend_address_pool_name  = "${local.backend_address_pool_name}"
    backend_http_settings_name = "${local.http_setting_name}"
  }

  tags = {
    project     = "${var.project}"
    environment = "${var.environment}"
  }
}

resource "azurerm_monitor_diagnostic_setting" "web_appgw_diagnostic" {
  count                      = "${length(var.log_analytics_config_map) != 0 ? 1 : 0}"
  name                       = "${format("%s-diagnostic", lookup(var.web_appgw_config_map, "name"))}"
  target_resource_id         = "${azurerm_application_gateway.web_appgw.id}"
  log_analytics_workspace_id = "${data.azurerm_log_analytics_workspace.log_analytics.id}"

  log {
    category = "ApplicationGatewayAccessLog"
    enabled  = true

    retention_policy {
      enabled = true
    }
  }

  log {
    category = "ApplicationGatewayFirewallLog"
    enabled  = true

    retention_policy {
      enabled = true
    }
  }

  log {
    category = "ApplicationGatewayPerformanceLog"
    enabled  = true

    retention_policy {
      enabled = true
    }
  }

  metric {
    category = "AllMetrics"
    enabled  = false

    retention_policy {
      enabled = false
    }
  }
}
