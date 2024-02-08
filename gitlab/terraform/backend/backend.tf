terraform {
  backend "azurerm" {
    resource_group_name  = "Samantha_M"
    storage_account_name = "gitlab2difsi4p5cmx34vwabk"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}