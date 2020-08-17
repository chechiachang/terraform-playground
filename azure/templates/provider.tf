provider "azurerm" {
  version = "~>v2.0.0"

  features {}

  skip_provider_registration = true # https://www.terraform.io/docs/providers/azurerm/index.html#skip_provider_registration
}
