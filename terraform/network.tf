# Azure Virtual Network
resource "azurerm_virtual_network" "nginx_vnet" {
  name                = "nginx-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.nginx_rg.location
  resource_group_name = azurerm_resource_group.nginx_rg.name
}

# Dedicated subnet for Azure Container Instance (ACI)
resource "azurerm_subnet" "aci_subnet" {
  name                 = "aci-subnet"
  resource_group_name  = azurerm_resource_group.nginx_rg.name
  virtual_network_name = azurerm_virtual_network.nginx_vnet.name
  address_prefixes     = ["10.0.2.0/24"]

  delegation {
    name = "aci-delegation"

    service_delegation {
      name = "Microsoft.ContainerInstance/containerGroups"
    }
  }
}
