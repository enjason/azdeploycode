output "azurerm_logic_app_workflow" {
  value = ["${azurerm_logic_app_workflow.logic_apps.*.id}"]
}
