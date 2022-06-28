###################################################
#### Define provider
###################################################
terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
    }
  }
}

###################################################
#### Define Azure Subscription and Tenant
###################################################
provider "azurerm" {
  features {}
  subscription_id = "5d77b6e5-6f1e-40a2-8cb7-350cd4e8c599"
  tenant_id       = "5ae1af62-9505-4097-a69a-c1553ef7840e"
}

###################################################
#### Create resource group
###################################################
resource "azurerm_resource_group" "rg" {
  name     = "BTH-MC-RG-${var.pod_name}"
  location = var.resource_group_location
}