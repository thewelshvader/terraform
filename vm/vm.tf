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
  virtual_network_name = var.network_name
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

resource "azurerm_linux_virtual_machine" "gdale_rancher_vm1" {
  name                = var.vm_name
  resource_group_name = var.rsg_rancher
  location            = "UK South"
  size                = "Standard_B4ms"
  admin_username      = "kevin"
  network_interface_ids = [
    azurerm_network_interface.vm_nic.id,
  ]

  admin_ssh_key {
    username   = "kevin"
    public_key = var.public_key
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}