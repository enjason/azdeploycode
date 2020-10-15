### create Elasticsearch load balancer

# -----------------------
data "azurerm_subnet" "web_subnet" {
  name                 = "${lookup(var.virtual_network_config_map, "web_subnet_name")}"
  virtual_network_name = "${lookup(var.virtual_network_config_map, "virtual_network_name")}"
  resource_group_name  = "${lookup(var.virtual_network_config_map, "resource_group_name")}"
}

data "azurerm_network_interface" "es_network_interface" {
  count               = "${length(var.es_lb_backend_vm)}"
  name                = "${element(formatlist("NIC01-%s", var.es_lb_backend_vm), count.index)}"
  resource_group_name = "${var.vm_resource_group_name}"
}

# ------------------------
resource "azurerm_lb" "es_lb" {
  name                = "${lookup(var.es_lb_config, "name")}"
  resource_group_name = "${data.azurerm_resource_group.azlb.name}"
  location            = "${var.location}"

  frontend_ip_configuration {
    private_ip_address            = "${cidrhost(data.azurerm_subnet.web_subnet.address_prefix, 16)}"
    name                          = "${format("%s_frontend_ip", lookup(var.es_lb_config, "name"))}"
    subnet_id                     = "${data.azurerm_subnet.web_subnet.id}"
    private_ip_address_allocation = "Static"
  }

  tags = {
    project     = "${var.project}"
    environment = "${var.environment}"
  }
}

resource "azurerm_lb_backend_address_pool" "es_lb_backend" {
  resource_group_name = "${data.azurerm_resource_group.azlb.name}"
  loadbalancer_id     = "${azurerm_lb.es_lb.id}"
  name                = "${format("%s_backend", lookup(var.es_lb_config, "name"))}"
}

resource "azurerm_lb_probe" "es_lb_http_probe" {
  resource_group_name = "${data.azurerm_resource_group.azlb.name}"
  loadbalancer_id     = "${azurerm_lb.es_lb.id}"
  name                = "${format("%s_http_probe", lookup(var.es_lb_config, "name"))}"
  protocol            = "tcp"
  port                = "${lookup(var.es_lb_config, "backend_port")}"
  request_path        = "${lookup(var.es_lb_config, "http_probe_path")}"
  interval_in_seconds = "300"
}

resource "azurerm_lb_rule" "es_lb_rule_with_http_probe" {
  resource_group_name            = "${data.azurerm_resource_group.azlb.name}"
  loadbalancer_id                = "${azurerm_lb.es_lb.id}"
  name                           = "${format("%s_rule", lookup(var.es_lb_config, "name"))}"
  protocol                       = "tcp"
  frontend_port                  = "${lookup(var.es_lb_config, "frontend_port")}"
  backend_port                   = "${lookup(var.es_lb_config, "backend_port")}"
  frontend_ip_configuration_name = "${format("%s_frontend_ip", lookup(var.es_lb_config, "name"))}"
  backend_address_pool_id        = "${azurerm_lb_backend_address_pool.es_lb_backend.id}"
  probe_id                       = "${azurerm_lb_probe.es_lb_http_probe.id}"
}

# ------------------------
resource "azurerm_network_interface_backend_address_pool_association" "es_lb" {
  count                   = "${length(var.es_lb_backend_vm)}"
  network_interface_id    = "${element(data.azurerm_network_interface.es_network_interface.*.id, count.index)}"
  ip_configuration_name   = "${element(formatlist("NIC01-%s-ipcfg", var.es_lb_backend_vm), count.index)}"
  backend_address_pool_id = "${azurerm_lb_backend_address_pool.es_lb_backend.id}"
}
