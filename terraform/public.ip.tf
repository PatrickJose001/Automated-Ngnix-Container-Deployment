# Public IP for the Nginx container
resource "azurerm_public_ip" "nginx_ip" {
  name                = "nginx-public-ip"
  location            = azurerm_resource_group.nginx_rg.location
  resource_group_name = azurerm_resource_group.nginx_rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
}
