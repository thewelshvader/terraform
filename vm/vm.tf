resource "azurerm_public_ip" "my_terraform_public_ip" {
  name                = "${var.vm_name}-publicip1"
  location            = "UK South"
  resource_group_name = var.rsg_rancher
  allocation_method   = "Dynamic"
}