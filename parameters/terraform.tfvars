terragrunt = {
  # Configure Terragrunt to automatically store tfstate files in an Azure Blob
  remote_state {
    backend = "azurerm"

    config {
      environment          = "china north2"
      storage_account_name = "storageaccountname"
      container_name       = "aztfstate"
      key                  = "${path_relative_to_include()}/terraform.tfstate"
      access_key           = "${get_env("BLOB_ACCESS_KEY", "")}"
    }
  }
}
