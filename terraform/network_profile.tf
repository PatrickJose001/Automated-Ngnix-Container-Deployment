# Network Profile for ACI
resource "azurerm_network_profile" "nginx_profile" {
  name                = "nginx-profile"
  location            = azurerm_resource_group.nginx_rg.location
  resource_group_name = azurerm_resource_group.nginx_rg.name

  container_network_interface {
    name = "aci-nic"

    ip_configuration {
      name      = "aci-ip-config"
      subnet_id = azurerm_subnet.aci_subnet.id
    }
  }
}
