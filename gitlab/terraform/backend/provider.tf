# Configure the Microsoft Azure Provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.90.0"
    }
  }
}
provider "azurerm" {
  features {}
  subscription_id = "c56aea2c-50de-4adc-9673-6a8008892c21"
}
