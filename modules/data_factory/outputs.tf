output "adf" {
  value = ["${azurerm_data_factory.adf.*.id}"]
}
