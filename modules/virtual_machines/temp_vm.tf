resource "azurerm_availability_set" "Salt_VM_AVASET" {
  name                         = "Suse_VM_AVASET"
  location                     = "${var.location}"
  resource_group_name          = "${data.azurerm_resource_group.virtual_machines_resource_group.name}"
  managed                      = true
  platform_fault_domain_count  = 2
  platform_update_domain_count = 5

  tags = {
    project     = "${var.project}"
    environment = "${var.environment}"
  }
}

resource "azurerm_network_interface" "salt_vm_network_interface" {
  count = "${lookup(var.salt_vm_config_map, "count")}"

  # VM name started from TEMPMCNINFVMSA0
  name                = "${format("NIC01-%s%02d", lookup(var.salt_vm_config_map, "name_prefix"), count.index )}"
  location            = "${var.location}"
  resource_group_name = "${data.azurerm_resource_group.virtual_machines_resource_group.name}"

  ip_configuration {
    name                          = "${format("NIC01-%s%02d-ipcfg", lookup(var.salt_vm_config_map, "name_prefix"), count.index )}"
    subnet_id                     = "${data.azurerm_subnet.app_subnet.id}"
    private_ip_address_allocation = "static"

    # IP address tarted from 192.168.100.0
    private_ip_address = "${cidrhost(data.azurerm_subnet.app_subnet.address_prefix,  5 + count.index)}"
  }

  tags = {
    project     = "${var.project}"
    environment = "${var.environment}"
  }
}


resource "azurerm_virtual_machine" "salt_vm" {
  count                 = "${lookup(var.salt_vm_config_map, "count")}"
  name                  = "${format("%s%02d", lookup(var.salt_vm_config_map, "name_prefix"), count.index )}"
  location              = "${var.location}"
  resource_group_name   = "${data.azurerm_resource_group.virtual_machines_resource_group.name}"
  network_interface_ids = ["${element(azurerm_network_interface.salt_vm_network_interface.*.id, count.index)}"]
  vm_size               = "${lookup(var.salt_vm_config_map, "size")}"
  availability_set_id   = "${azurerm_availability_set.Salt_VM_AVASET.id}"
  delete_os_disk_on_termination = true
  
  storage_image_reference {
    publisher = "SUSE"
    offer     = "SLES"
    sku       = "12-SP4"
    version   = "latest"
  }

  storage_os_disk {
    name              = "${format("%s%02d-os-disk", lookup(var.salt_vm_config_map, "name_prefix"), count.index )}"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    disk_size_gb      = 30
    managed_disk_type = "Standard_LRS"
    os_type           = "Linux"
  }

  os_profile {
    computer_name  = "${format("%s%02d", lookup(var.salt_vm_config_map, "name_prefix"), count.index )}"
    admin_username = "${var.admin_username}"
    admin_password = "${var.admin_password}"
  }

  os_profile_linux_config {
    disable_password_authentication = false

    #ssh_keys {
    #  path     = "/home/${var.admin_username}/.ssh/authorized_keys"
    #  key_data = "${file("./data/ssh_key")}"
    #}
  }

  boot_diagnostics {
    enabled     = true
    storage_uri = "${var.diagnostics_uri }"
  }

  tags = {
    project     = "${var.project}"
    service     = "TEST"
    purpose     = "DevOps"
    imagetype   = "offical"
    environment = "${var.environment}"
  }
}
