
resource "azurerm_linux_virtual_machine" "vm" {
  name                            = "${var.name}-vm"
  resource_group_name             = var.resource_group_name
  location                        = var.location
  size                            = var.size
  admin_username                  = var.admin_username
  admin_password                  = var.admin_password
  disable_password_authentication = "false"
  network_interface_ids = [
    var.network_interface_id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "RedHat"
    offer     = "RHEL"
    sku       = "8"
    version   = "latest"
  }
}