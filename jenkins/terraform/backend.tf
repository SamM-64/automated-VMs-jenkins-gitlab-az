resource "azurerm_storage_account" "tfstate" {
  name                     = "${replace(replace(lower(data.azurerm_resource_group.main.name), "_", ""), "-", "")}tfstatejenkins"
  resource_group_name      = data.azurerm_resource_group.main.name
  location                 = data.azurerm_resource_group.main.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "tfstate" {
  name                  = "tfstatejenkins"
  storage_account_name  = azurerm_storage_account.tfstate.name
  container_access_type = "private"
}