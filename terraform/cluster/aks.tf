# data "azurerm_client_config" "current" {}
# data "azurerm_virtual_network" "vnet-hub" {
#   name                 = "vnet-hub"  
#   resource_group_name  = var.resource_group_name   
# }
# data "azurerm_virtual_network" "vnet-prd" {
#   name                 = "vnet-prd"  
#   resource_group_name  = var.resource_group_name   
# }

# data "azurerm_subnet" "sub-aks" {
#   name                 = "sub-aks"  
#   virtual_network_name = var.vnet_prd_name
#   resource_group_name  = var.resource_group_name   
# }

# # resource "azuread_group" "elo-gp" {
# #   display_name     = "elo-gp"
# #   owners           = [data.azuread_client_config.current.object_id]
# #   security_enabled = true
# # }

# # resource "azuread_group_member" "seddine-user" {
# #   group_object_id  = azuread_group.elo-gp.id
# #   member_object_id = data.azuread_client_config.current.
# # }

# resource "azurerm_private_dns_zone" "aks_dns_zone" {
# name                = "prod.private.westus.azmk8s.io"
# resource_group_name = var.resource_group_name
# }

# resource "azurerm_private_dns_zone_virtual_network_link" "zone-dns-peer-hub" {
#   name                  = "zone-dns-peer-hub"
#   private_dns_zone_name = azurerm_private_dns_zone.aks_dns_zone.name
#   resource_group_name   = var.resource_group_name
#   virtual_network_id    = data.azurerm_virtual_network.vnet-hub.id
#   registration_enabled  = true
#   depends_on = [ azurerm_private_dns_zone.aks_dns_zone ]
# }

# resource "azurerm_private_dns_zone_virtual_network_link" "zone-dns-peer-prd" {
#   name                  = "zone-dns-peer-prd"
#   private_dns_zone_name = azurerm_private_dns_zone.aks_dns_zone.name
#   resource_group_name   = var.resource_group_name
#   virtual_network_id    = data.azurerm_virtual_network.vnet-prd.id
#   registration_enabled  = true
#   depends_on = [ azurerm_private_dns_zone.aks_dns_zone ]
# }
# # resource "azurerm_user_assigned_identity" "aks_identity" {
# #   name                = "aks-dns-identity"
# #   location            = var.location
# #   resource_group_name = var.resource_group_name
# # }
# resource "azurerm_kubernetes_cluster" "aks-prd" {

#   name                = var.aks_cluster_name
#   location            = var.location
#   resource_group_name = var.resource_group_name
#   dns_prefix          = var.aks_dns_prefix
#  private_dns_zone_id                 = azurerm_private_dns_zone.aks_dns_zone.id
#   private_cluster_enabled             = true
#  private_cluster_public_fqdn_enabled = false
 
#   azure_active_directory_role_based_access_control {
#     # managed             = true
#     # tenant_id           = var.tenant_id
#     azure_rbac_enabled  = true
#   }
  

#   default_node_pool {
#     vnet_subnet_id  = data.azurerm_subnet.sub-aks.id
#     name           = var.aks_node_pool_name
#     node_count     = var.aks_node_count
#     vm_size        = var.aks_node_vm_size
#     os_disk_size_gb = var.aks_node_os_disk_size_gb
#      temporary_name_for_rotation = "recycle0" 
    
#   }

# #  identity {
# #     type = "SystemAssigned"
# #   }

#   network_profile {
#     load_balancer_sku = "standard"
#     network_plugin   = "azure"
#     network_policy    = "azure"
#   }

#     service_principal {
#     client_id     = "7e2c6040-4398-4c31-9d97-474f7b52e024"
#     client_secret = "PbD8Q~gxzLCM1evA6sC7gi55fqQhT.vJ_2PYKcbz"
#   }
  
#   depends_on = [ azurerm_private_dns_zone_virtual_network_link.zone-dns-peer-prd ]
# }

# resource "azurerm_role_assignment" "aks_rbac" {
#   scope                = azurerm_kubernetes_cluster.aks-prd.id   
#   role_definition_name = data.azurerm_client_config.current.client_id  
#   principal_id         = data.azurerm_client_config.current.object_id   
#   depends_on = [ azurerm_kubernetes_cluster.aks-prd ]
# }


# provider "kubernetes" {
#   host                   = data.azurerm_kubernetes_cluster.aks.kube_config.0.host
#   client_certificate     = base64decode(data.azurerm_kubernetes_cluster.aks.kube_config.0.client_certificate)
#   client_key             = base64decode(data.azurerm_kubernetes_cluster.aks.kube_config.0.client_key)
#   cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.aks.kube_config.0.cluster_ca_certificate)
# }
