
module "my-virtual-machine" {
  source = "../modules/virtual_machine"
  providers = {
    azurerm = azurerm
  }

  resource_group_name = var.resource_group_name
  location            = var.location
  name                = "my-virtual-machine"
  vm_size             = "Standard_B1ls" # 1 vcpu, 0.5 Gi Memory = $0.0075/hour

  subnet_id = azurerm_subnet.internal.id
}
