
# az group list
# terraform import azurerm_resource_group.primary "/subscriptions/12345678-1234-1234-1234-123456789012/resourceGroups/test-resource-group"
resource "azurerm_resource_group" "primary" {
  name     = var.resource_group_name
  location = var.location
}
