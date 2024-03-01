terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}
provider "azurerm" {
    features {}
}

variable "rsg_rancher" {
  type = string
  default = "placeholder"
}
variable "rsg_network" {
  type = string
  default = "placeholder"
}
variable "network_name" {
  type = string
  default = "placeholder"
}
