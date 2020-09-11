
resource "azurerm_storage_share" "default" {
  name                 = var.file_share_name
  storage_account_name = var.storage_account
  quota                = 50
}
