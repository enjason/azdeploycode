output "log_analytics_workspace" {
  value = "${azurerm_log_analytics_workspace.log_analytics_workspace.workspace_id}"
}
