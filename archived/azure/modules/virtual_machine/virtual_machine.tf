
resource "azurerm_network_interface" "my-virtual-machine" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "dynamic-internal-ip"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

locals {
  username = var.username == null ? var.name : var.username # Use vm name as username if null
}

# az vm list
resource "azurerm_virtual_machine" "my-virtual-machine" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  vm_size             = var.vm_size
  network_interface_ids = [
    azurerm_network_interface.my-virtual-machine.id
  ]

  delete_os_disk_on_termination    = true
  delete_data_disks_on_termination = false

  storage_image_reference {
    publisher = var.storage_image_reference_publisher
    offer     = var.storage_image_reference_offer
    sku       = var.storage_image_reference_sku
    version   = var.storage_image_reference_version
  }
  storage_os_disk {
    name              = "${var.name}-osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = var.name
    admin_username = local.username
  }
  os_profile_linux_config {
    disable_password_authentication = true # Always disable password login
    ssh_keys {
      key_data = file("~/.ssh/id_rsa.pub")
      path     = "/home/${local.username}/.ssh/authorized_keys"
    }
  }
  tags = {}

  depends_on = [
    azurerm_network_interface.my-virtual-machine
  ]
}
