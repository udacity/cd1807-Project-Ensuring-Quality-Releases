#data "azurerm_virtual_network" "test" {
#  name                 = "${var.application_type}-NET"
#  resource_group_name  = "${var.resource_group}"
#}

#data "azurerm_subnet" "test" {
#  name                 = "${var.application_type}-NET-sub"
#  virtual_network_name = "${var.application_type}-NET"
##  resource_group_name  = "${var.resource_group}"
#}

##data "azurerm_public_ip" "test" {
#  name                = "${var.application_type}-publicip-pubip"
#  resource_group_name = "${var.resource_group}"
#}

resource "azurerm_network_interface" "test" {
  name                = "${var.application_type}-${var.resource_type}"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group}"

  ip_configuration {
    name                          = "internal"
    subnet_id                     = "${var.application_type}-NET" #"myApplication-NET"
    #subnet_id                     = data.azurerm_subnet.test.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = "${var.application_type}-publicip-pubip" #"myApplication-publicip-pubip" 
    #public_ip_address_id          = data.azurerm_public_ip.test.id 
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
#  admin_ssh_key {
#    username   = "adminuser"
#    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCe+85RdeEz+9UVLdmToflPtHREOLFpODV/HR1aQoyP+veU4dEYF/gdvHkHOCBNl/x9wNeitr9tzrc0AGjy2hEFGjRdOrT7XG1nZ6a6Mhjd9yTT3ghDk8p8ipYQqbmqyTQphNT9ym4qSOJ1zakCjM6a4M7HB7AyhS8ddI1xGxPH5q2XSh5HC95/1hxrgXFakjNT2Zw//D9LT2gQdIZuuBUPE/8+SjEPa97Qe8m6W9WCkulEFzLzK0TsM6cQ8y0eCrmh30lWfT7XHm2w0kLvj4POL8+2BCCb+dcbBxV/oH4Z9xemBk84psFbixHIVUNIbJuYQORPlWf9wzCD7mjti0C1HFGBjCQyTqDaYjXW91ifIotJiIGILeZ1ZA7XiC9dbiJF8pwPsi3OjT3ehcxrue19/f7mTJ07CJIqTIKF6DL0CLmfZj+ae44jmysihCdJvbia+pRgvwlH5fm9551LL3F3J4O1xRIBIKLSwbiHZqUxEzu8UtwIOyafez0HdWWFRkc= wojsiw@DESKTOP-AVL1658"
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
