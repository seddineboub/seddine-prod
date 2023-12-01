
resource "azurerm_virtual_network" "vnet-prd" {
  name                = var.vnet_prd_name
  address_space       = var.address_space
  location            = var.location
  resource_group_name = var.resource_group_name
}
