# data "azurerm_virtual_network" "vnet-prd" {
#   name                 = "vnet-prd"  
#   resource_group_name  = var.resource_group_name   
# }
# data "azurerm_subnet" "sub-gateway" {
#   name                 = "sub-gateway"  
#   virtual_network_name = var.vnet_prd_name
#   resource_group_name  = var.resource_group_name   
# }

# # Create App Gateway NSG
# resource "azurerm_network_security_group" "sub-nsg-gtw" {
#   name                = "sub-nsg-gtw"
#   location            = var.location
#   resource_group_name = var.resource_group_name
#   depends_on = [ data.azurerm_subnet.sub-gateway]
# }

# # Allow required inbound traffic on App Gateway NSG
# resource "azurerm_network_security_rule" "app_gateway_inbound" {
#   name                        = "allow-appgw-inbound"
#   priority                    = 1001
#   direction                   = "Inbound"
#   access                      = "Allow"
#   protocol                    = "*"
#   source_port_range           = "*"
#   destination_port_range      = "*"
#   source_address_prefix       = "*"
#   destination_address_prefix  = "*"
#   resource_group_name         = var.resource_group_name
#   network_security_group_name = azurerm_network_security_group.sub-nsg-gtw.name
#   depends_on = [ azurerm_network_security_group.sub-nsg-gtw ]
# }

# resource "azurerm_subnet" "frontend" {
#   name                 = "frontend"
#   resource_group_name  = var.resource_group_name
#   virtual_network_name = var.vnet_prd_name
#   address_prefixes     = ["10.102.3.0/24"]
# depends_on = [ data.azurerm_virtual_network.vnet-prd ]
# }

# resource "azurerm_public_ip" "gateway-public-ip" {
#   name                = "gateway-public-ip"
#   resource_group_name = var.resource_group_name
#   location            = var.location
#   allocation_method   = "Static"
#   sku                 = "Standard"

# }

# # re-used - a locals block makes this more maintainable
# locals {
#   backend_address_pool_name      = "${var.vnet_prd_name}-beap"
#   frontend_port_name             = "${var.vnet_prd_name}-feport"
#   frontend_ip_configuration_name = "${var.vnet_prd_name}-feip"
#   http_setting_name              = "${var.vnet_prd_name}-be-htst"
#   listener_name                  = "${var.vnet_prd_name}-httplstn"
#   request_routing_rule_name      = "${var.vnet_prd_name}-rqrt"
#   redirect_configuration_name    = "${var.vnet_prd_name}-rdrcfg"
# }


# # Define the public IP address
# resource "azurerm_public_ip" "app_gateway_public_ip" {
#   name                = "app-gateway-public-ip"
#   resource_group_name = azurerm_resource_group.rg.name
#   location            = var.location
#   allocation_method   = "Static"
#   sku                 = "Standard"
# }

# # Define the application gateway
# resource "azurerm_application_gateway" "app_gateway" {
#   name                = "app-gateway"
#   resource_group_name = azurerm_resource_group.rg.name
#   location            = var.location
#   sku {
#     name     = "Standard_v2"
#     tier     = "Standard_v2"
#     capacity = 2
#   }
#   gateway_ip_configuration {
#     name      = "app-gateway-ip-configuration"
#     subnet_id = azurerm_subnet.frontend.id
#     public_ip_address_id = azurerm_public_ip.app_gateway_public_ip.id
#   }
#   frontend_port {
#     name = "http"
#     port = 80
#   }
#   frontend_ip_configuration {
#     name                 = "app-gateway-ip-configuration"
#     public_ip_address_id = azurerm_public_ip.app_gateway_public_ip.id
#   }
#   backend_address_pool {
#     name = "backend-pool"
#     # Add backend addresses if needed
#   }
#   backend_http_settings {
#     name                  = "http-settings"
#     cookie_based_affinity = "Disabled"
#     protocol              = "Http"
#     port                  = 80
#     request_timeout       = 20
#   }

#   http_listener {
#     name                           = "http-listener"
#     frontend_ip_configuration_name = "app-gateway-ip-configuration"
#     frontend_port_name             = "http"
#     protocol                       = "Http"
#   }

#   request_routing_rule {
#     name                       = "nginx-route"
#     rule_type                  = "Basic"
#     http_listener_name         = "http-listener"
#     backend_address_pool_name  = "backend-pool"
#     backend_http_settings_name = "http-settings"
#     # Match requests with the path /nginx
#     url_path_map {
#       name      = "nginx-path-map"
#       default_backend_address_pool_id = azurerm_application_gateway_backend_address_pool.backend.id
#       default_backend_http_settings_id = azurerm_application_gateway_http_settings.backend.id
#       path_rules {
#         name      = "nginx-path-rule"
#         paths     = ["/nginx/*"]
#         backend_address_pool_id = azurerm_application_gateway_backend_address_pool.backend.id
#         backend_http_settings_id = azurerm_application_gateway_http_settings.backend.id
#       }
#     }
#   }

#   # Add similar request_routing_rule blocks for /jenkins and /wordpress paths
# }

# # Define the subnet where the Application Gateway will reside
# resource "azurerm_subnet" "frontend" {
#   name                 = "frontend"
#   resource_group_name  = var.resource_group_name
#   virtual_network_name = var.vnet_name
#   address_prefixes     = ["10.0.1.0/24"]  # Adjust the subnet CIDR as needed
# }
