resource "azurerm_public_ip" "vm_public_ip" {
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

resource "azurerm_subnet" "snet-rancher-main" {
  name                 = var.subnet_name
  resource_group_name  = var.rsg_network
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.0.0.0/26"]
}

resource "azurerm_network_interface" "vm_nic" {
  name                = "${var.vm_name}-nic1"
  location            = "UK South"
  resource_group_name = var.rsg_rancher

  ip_configuration {
    name                          = "${var.vm_name}_nic_config"
    subnet_id                     = azurerm_subnet.snet-rancher-main.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.vm_public_ip.id
  }
}

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "example" {
  network_interface_id      = azurerm_network_interface.vm_nic.id
  network_security_group_id = azurerm_network_security_group.rancher_nsg.id
}