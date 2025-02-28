// Terraform outputs


output "instance1_public_ip" {
  value = azurerm_container_group.instance1.ip_address
}

output "instance1_container_name" {
  value = azurerm_container_group.instance1.name
}
