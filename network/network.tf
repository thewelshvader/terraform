resource "azurerm_virtual_network" "main" {
  name                = var.network_name
  address_space       = ["10.0.0.0/24"]
  location            = "UK South"
  resource_group_name = var.rsg_network
}

resource "azurerm_subnet" "snet-rancher-main" {
  name                 = var.subnet_name
  resource_group_name  = var.rsg_network
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.0.0.0/26"]
}