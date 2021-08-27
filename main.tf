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
}

module "radditvm" {
  source  = "app.terraform.io/vpdemo/radditvm/azurerm"
  version = "0.9.4"

  vpc_subnet = module.radditnetwork.subnet_name
  vpc_nsg = module.radditnetwork.nsg
}

module "radditconfig" {
  source  = "app.terraform.io/vpdemo/radditconfig/azurerm"
  version = "1.2.0"

  vpc_hostname = module.radditvm.public_ip
}
