
# az network vnet list
resource "azurerm_virtual_network" "internal" {
  resource_group_name = var.resource_group_name

  name          = "internal"
  address_space = ["10.0.0.0/16"]
  location      = var.location

  depends_on = [
    azurerm_resource_group.primary
  ]
}

resource "azurerm_subnet" "internal" {
  resource_group_name = var.resource_group_name

  name                 = "internal"
  virtual_network_name = "internal"
  address_prefix       = "10.0.0.0/24"

  depends_on = [
    azurerm_virtual_network.internal
  ]
}
