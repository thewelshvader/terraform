resource "azurerm_resource_group" "rancher" {
  name     = var.rsg_rancher
  location = "UK South"
}
resource "azurerm_resource_group" "network" {
  name     = var.rsg_network
  location = "UK South"
}