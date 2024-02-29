resource "azurerm_resource_group" "rancher" {
  name     = "rsg-rancher"
  location = "UK South"
}
resource "azurerm_resource_group" "network" {
  name     = "rsg-network"
  location = "UK South"
}