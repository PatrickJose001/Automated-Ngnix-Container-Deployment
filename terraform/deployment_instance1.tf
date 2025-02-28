

resource "azurerm_container_group" "instance1" {
  name                = "instance1-5h1cmlt0"
  location            = azurerm_resource_group.nginx_rg.location
  resource_group_name = azurerm_resource_group.nginx_rg.name
  os_type             = "Linux"
  ip_address_type     = "Public"
  network_profile_id  = azurerm_network_profile.nginx_profile.id

  container {
    name   = "instance1"
    image  = "nginx:latest"
    cpu    = 0.5
    memory = 1.5

    ports {
      port     = 80
      protocol = "TCP"
    }
  }

  tags = {
    environment = "development"
  }

  image_registry_credential {
    server   = "index.docker.io"
    username = var.docker_username
    password = var.docker_password
}


  depends_on = [azurerm_subnet.aci_subnet]  # Ensures subnet is created before the container group
}
