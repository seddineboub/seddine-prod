# getting inputs from data source 
data "azuread_client_config" "current" {}

# application gateway res
data "azurerm_application_gateway" "app-gtw-prd" {
  name = "app-gtw-prd"
 resource_group_name = var.resource_group_name 
}
# application gateway res
data "azurerm_virtual_network" "vnet-hub" {
  name                 = "vnet-hub"  
  resource_group_name  = var.resource_group_name   
}
# application gateway res
data "azurerm_virtual_network" "vnet-prd" {
  name                 = "vnet-prd"  
  resource_group_name  = var.resource_group_name   
}
# application gateway res
data "azurerm_subnet" "sub-aks" {
  name                 = "sub-aks"  
  virtual_network_name = var.vnet_prd_name
  resource_group_name  = var.resource_group_name   
}
//--> resource creation 

# creating group and setting owner as the current client
resource "azuread_group" "aks-group" {
  display_name     = "aks-group"
  owners           = [data.azuread_client_config.current.object_id]
  security_enabled = true
}
# creating member and setting owner as the previous gp
resource "azuread_group_member" "seddine_member" {
  group_object_id  = azuread_group.aks-group.id
  member_object_id = data.azuread_client_config.current.object_id
}

# creating a private dns zone for aks
resource "azurerm_private_dns_zone" "private-zone" {
  name                = var.aks_dns_zone_name
  resource_group_name = var.resource_group_name
}

# linking the dns peer to peer with both vnet-prd and vnet-prd
# .....vnet-hub
resource "azurerm_private_dns_zone_virtual_network_link" "zone-dns-peer-hub" {
  name                  = "zone-dns-peer-hub"
  private_dns_zone_name = azurerm_private_dns_zone.private-zone.name
  resource_group_name   = var.resource_group_name
  virtual_network_id    = data.azurerm_virtual_network.vnet-hub.id
  registration_enabled  = true
}
# ..... vnet-prd
resource "azurerm_private_dns_zone_virtual_network_link" "zone-dns-peer-prd" {
  name                  = "zone-dns-peer-prd"
  private_dns_zone_name = azurerm_private_dns_zone.private-zone.name
  resource_group_name   = var.resource_group_name
  virtual_network_id    = data.azurerm_virtual_network.vnet-prd.id
  registration_enabled  = true
}

resource "azurerm_kubernetes_cluster" "aks-prd" {
  depends_on = [azurerm_private_dns_zone.private-zone,
               data.azurerm_application_gateway.app-gtw-prd,
               ]
  name                                = var.aks_cluster_name
  location                            = var.location
  resource_group_name                 = var.resource_group_name
  dns_prefix                          = "seddine"
  private_dns_zone_id                 = azurerm_private_dns_zone.private-zone.id
  private_cluster_enabled             = true
  private_cluster_public_fqdn_enabled = false

  default_node_pool {
    vnet_subnet_id  = data.azurerm_subnet.sub-aks.id
    name           = var.aks_node_pool_name
    node_count     = var.aks_node_count
    vm_size        = var.aks_node_vm_size
    os_disk_size_gb = var.aks_node_os_disk_size_gb
  }

  azure_active_directory_role_based_access_control {
    managed                = true
    admin_group_object_ids = [azuread_group.aks-group.id]
  }
   ingress_application_gateway {
    gateway_id = data.azurerm_application_gateway.app-gtw-prd.id 
  }
  service_principal {
    client_id     = var.client_id
    client_secret = var.client_secret
  }
  network_profile {
    load_balancer_sku = "standard"
    network_plugin   = "azure"
    network_policy    = "azure"
  }
  tags = {
    Environment = "private-aks-prd"
  }
}


//-RBAC- currently commented due to error because of limited role autorisations
# resource "azurerm_role_assignment" "aks_rbac" {
#   scope                = azurerm_kubernetes_cluster.aks-prd.id   
#   role_definition_name = data.azurerm_client_config.current.client_id  
#   principal_id         = data.azurerm_client_config.current.object_id   
#   depends_on = [ azurerm_kubernetes_cluster.aks-prd ]
# }


