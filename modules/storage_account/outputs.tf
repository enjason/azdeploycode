output "vm_diagnostics_storage_account" {
  value = "${azurerm_storage_account.vm_diagnostics_storage_account.primary_blob_host}"
}

output "appgw_diagnostics_storage_account" {
  value = "${azurerm_storage_account.appgw_diagnostics_storage_account.primary_blob_host}"
}

output "storage_accounts" {
  value = "${azurerm_storage_account.storage_accounts.*.primary_blob_host}"
}
