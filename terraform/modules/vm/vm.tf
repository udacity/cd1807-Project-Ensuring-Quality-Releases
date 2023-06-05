resource "azurerm_network_interface" "" {
  name                = "${var.nic_name}"
  location            = "${var.rg_location}"
  resource_group_name = "${var.rg_name}"

  ip_configuration {
    name                          = "internal"
    subnet_id                     = "azurerm_subnet".subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = "".public_ip_address_id
  }
}

resource "azurerm_linux_virtual_machine" "" {
  name                = "${var.vm_name}"
  location            = "${var.rg_location}"
  resource_group_name = "${var.rg_name}"
  size                = "Standard_DS2_v2"
  admin_username      = "${var.admin_username}"
  network_interface_ids = []
  admin_ssh_key {
    username   = "adminuser"
    public_key = "file("~/.ssh/id_rsa.pub")"
  }
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
