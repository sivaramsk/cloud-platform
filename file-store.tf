resource "azurerm_storage_account" "default" {
  name                = "intaindevstorageaccount"
  location            = azurerm_resource_group.default.location
  resource_group_name = azurerm_resource_group.default.name
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_share" "default" {
  name                 = "akssharedstore"
  storage_account_name = azurerm_storage_account.default.name
  resource_group_name = azurerm_resource_group.default.name
  quota                = 50
}
