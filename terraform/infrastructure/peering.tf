data "azurerm_virtual_network" "vnet-hub" {
  name                 = "vnet-hub"  
  resource_group_name  = var.resource_group_name   
}

resource "azurerm_virtual_network_peering" "hub_to_prod" {
  name                         = "prd-peer-hub"
  resource_group_name          = var.resource_group_name
  virtual_network_name         = azurerm_virtual_network.vnet-prd.name
  remote_virtual_network_id    = data.azurerm_virtual_network.vnet-hub.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  allow_gateway_transit        = true

}

resource "azurerm_virtual_network_peering" "prod_to_hub" {
  name                         = "hub-peer-prd"
  resource_group_name          = var.resource_group_name
  virtual_network_name         = data.azurerm_virtual_network.vnet-hub.name
  remote_virtual_network_id    = azurerm_virtual_network.vnet-prd.id 
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  allow_gateway_transit        = true
}