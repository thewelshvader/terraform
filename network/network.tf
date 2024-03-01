resource "azurerm_virtual_network" "main" {
  name                = var.network_name
  address_space       = ["10.0.0.0/24"]
  location            = "UK South"
  resource_group_name = var.rsg_network
}