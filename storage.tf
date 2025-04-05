terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.0.0"
    }
  }
  required_version = ">= 1.0.0"
}

# configuring  the Azure Provider
provider "azurerm" {
  subscription_id = "c7409804-251d-48cf-8221-e5209fe46940"
  tenant_id       = "0a447afb-ebd9-4144-b8da-5afec13f8fc7"

  features {

  }
  resource_provider_registrations = "none"
}

# Creating a new resource group
resource "azurerm_resource_group" "new_rg" {
  name     = "new_storage_res_grp"
  location = "East US"
}

# Creating a Storage Account with a new name 
resource "azurerm_storage_account" "new_storage" {
  name                     = "ashishstorage"
  resource_group_name      = azurerm_resource_group.new_rg.name
  location                 = azurerm_resource_group.new_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "TerraformDemo"
  }
}

# Creating a storage container with a new name

resource "azurerm_storage_container" "new_container" {
  name                  = "ashishcontainer"
  storage_account_id    = azurerm_storage_account.new_storage.id
  container_access_type = "private"
}
