resource "azurerm_public_ip" "my_terraform_public_ip" {
  name                = "${var.vm_name}-publicip1"
  location            = "UK South"
  resource_group_name = var.rsg_rancher
  allocation_method   = "Dynamic"
}
resource "azurerm_network_security_group" "rancher_nsg" {
  name                = "${var.vm_name}-nsg"
  location            = "UK South"
  resource_group_name = var.rsg_rancher

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}