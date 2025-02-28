# Azure Resource Group
resource "azurerm_resource_group" "nginx_rg" {
  name     = "nginx-deployment-rg"
  location = "West Europe"
}
