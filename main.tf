terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>2.0"
    }
  }
}

provider "azurerm" {
  features {}
}

module "radditnetwork" {
  source  = "app.terraform.io/vpdemo/radditnetwork/azurerm"
  version = "1.0.2"
  
  hashirg = var.hashirg
  hashiregion = var.hashiregion
}

module "radditvm" {
  source  = "app.terraform.io/vpdemo/radditvm/azurerm"
  version = "0.9.4"

  vpc_subnet = module.radditnetwork.subnet_name
  vpc_nsg = module.radditnetwork.nsg
  user_name = var.user_name
  user_password = var.user_password
  hashirg = var.hashirg
  hashiregion = var.hashiregion
}

module "radditconfig" {
  source  = "app.terraform.io/vpdemo/radditconfig/azurerm"
  version = "1.2.0"

  vpc_hostname = module.radditvm.public_ip
  user_name = var.user_name
  user_password = var.user_password
}
