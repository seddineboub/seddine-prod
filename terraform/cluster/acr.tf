

# creating active directory registry

resource "azurerm_container_registry" "acr" {
  name                     = "eloacrprd"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  sku                      = "Standard"  
  admin_enabled            = true  
  # georeplication_locations = []    # Add geo-replication locations 

  # network_rule_set {
  #   default_action = "Deny"
  #   ip_rules       = [""] # Whitelist IP rules if required
  # }
  tags = {
    environment = "acr-prd"
  }
}