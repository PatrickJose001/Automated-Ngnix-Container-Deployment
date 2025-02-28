# provider "azurerm" {
#   features {}

#   client_id       = var.AZURE_CLIENT_ID
#   client_secret   = var.AZURE_CLIENT_SECRET
#   tenant_id       = var.AZURE_TENANT_ID
#   subscription_id = var.AZURE_SUBSCRIPTION_ID
# }
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.0"
    }
  }
}

provider "azurerm" {
  features {}
}