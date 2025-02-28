

resource "azurerm_container_group" "${unique_name}" {
  name                = "${unique_name}-${random_id}"
  location            = azurerm_resource_group.nginx_rg.location
  resource_group_name = azurerm_resource_group.nginx_rg.name
  os_type             = "Linux"
  ip_address_type     = "Public"
  network_profile_id  = azurerm_network_profile.nginx_profile.id

  container {
    name   = "${unique_name}"
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
    username = var.DOCKER_USERNAME
    password = var.DOCKER_PASSWORD
}


  depends_on = [azurerm_subnet.aci_subnet]  # Ensures subnet is created before the container group
}
