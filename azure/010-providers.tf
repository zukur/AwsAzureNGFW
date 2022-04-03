# We strongly recommend using the required_providers block to set the
# Azure Provider source and version being used

terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
  #subscription_id = ""
  #tenant_id       = ""
}

# Create a resource group
resource "azurerm_resource_group" "rg" {
  name     = "BTH-MC-RG-${var.pod_name}"
  location = var.resource_group_location
}