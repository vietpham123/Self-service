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
  version = "1.0.1"
}

module "radditvm" {
  source  = "app.terraform.io/vpdemo/radditvm/azurerm"
  version = "0.9.0"

  subnet_id = module.radditnetwork.subnet_name
}

module "radditconfig" {
  source  = "app.terraform.io/vpdemo/radditconfig/azurerm"
  version = "1.0.0"

  host = module.radditvm.public_ip
}
