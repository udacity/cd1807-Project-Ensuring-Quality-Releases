provider "azurerm" {
  tenant_id       = "${var.tenant_id}"
  subscription_id = "${var.subscription_id}"
  client_id       = "${var.client_id}"
  client_secret   = "${var.client_secret}"
  features {}
}

terraform {
  backend "azurerm" {
    storage_account_name = "tfstate185051967"
    container_name       = "tfstate"
    key                  = "test.terraform.tfstate"
    access_key           = "tL8M2MnN89tSzdOg5xUWCfcOctxFnjW60RI4TsY0LaC/3fzY84v+FMktTgydRnDPYl+6ZRkjcVQl+AStYsOhWw=="
  }
}

#module "resource_group" {
#  source               = "../../modules/resource_group"
#  resource_group       = "${var.resource_group}"
#  location             = "${var.location}"
#}

module "network" {
  source               = "../../modules/network"
  address_space        = "${var.address_space}"
  location             = "${var.location}"
  virtual_network_name = "${var.virtual_network_name}"
  application_type     = "${var.application_type}"
  resource_type        = "NET"
#  resource_group       = "${module.resource_group.resource_group_name}"
  resource_group    = "${var.resource_group}"
  address_prefix_test  = "${var.address_prefix_test}"
  address_prefixes_test  = "${var.address_prefixes_test}"
}

module "nsg-test" {
  source           = "../../modules/networksecuritygroup"
  location         = "${var.location}"
  application_type = "${var.application_type}"
  resource_type    = "NSG"
#  resource_group   = "${module.resource_group.resource_group_name}"
  resource_group    = "${var.resource_group}"
  subnet_id        = "${module.network.subnet_id_test}"
  address_prefix_test = "${var.address_prefix_test}"
}
module "appservice" {
  source           = "../../modules/appservice"
  location         = "${var.location}"
  application_type = "${var.application_type}"
  resource_type    = "AppService"
  resource_group    = "${var.resource_group}"
#  resource_group   = "${module.resource_group.resource_group_name}"
}
module "publicip" {
  source           = "../../modules/publicip"
  location         = "${var.location}"
  application_type = "${var.application_type}"
  resource_type    = "publicip"
  resource_group    = "${var.resource_group}"
}
module "vm" {
  source           = "../../modules/vm"
  location         = "${var.location}"
  application_type = "${var.application_type}"
  resource_type    = "VM"
  resource_group   = "${var.resource_group}"
  subnet_id        = "${module.network.subnet_id_test}"
  public_ip_address_id          = "${module.publicip.public_ip_address_id}" 
}