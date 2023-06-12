#data "azurerm_virtual_network" "test" {
#  name                 = "${var.application_type}-NET"
#  resource_group_name  = "${var.resource_group}"
#}

data "azurerm_subnet" "test"{
  name                 = "${var.application_type}-NET-sub"
  virtual_network_name = "${var.application_type}-NET"
  resource_group_name  = "${var.resource_group}"
}

data "azurerm_public_ip" "test"{
  name                = "${var.application_type}-publicip-pubip"
  resource_group_name = "${var.resource_group}"
}

resource "azurerm_network_interface" "test" {
  name                = "${var.application_type}-${var.resource_type}"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group}"

  ip_configuration {
    name                          = "internal"
    #subnet_id                     = "myApplication-NET"
    subnet_id                     = data.azurerm_subnet.test.id
    private_ip_address_allocation = "Dynamic"
    #public_ip_address_id          = "myApplication-publicip-pubip" 
    public_ip_address_id          = data.azurerm_public_ip.test.id 
  }
}

resource "azurerm_linux_virtual_machine" "test" {
  name                = "${var.application_type}-${var.resource_type}"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group}"
  size                = "Standard_DS2_v2"
  admin_username      = "adminuser"
  admin_password      = "adminuserP@55"
  disable_password_authentication = "false"
  network_interface_ids = [
    azurerm_network_interface.test.id,
  ]
#  admin_ssh_key {
#    username   = "adminuser"
#    public_key = "file("~/.ssh/id_rsa.pub")"
#  }
  os_disk {
    caching           = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}
