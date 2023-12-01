data "azurerm_virtual_network" "vnet-prd" {
  name                 = "vnet-prd"  
  resource_group_name  = var.resource_group_name   
}
data "azurerm_subnet" "sub-gateway" {
  name                 = "sub-gateway"  
  virtual_network_name = var.vnet_prd_name
  resource_group_name  = var.resource_group_name   
}

# Create App Gateway NSG
resource "azurerm_network_security_group" "sub-nsg-gtw" {
  name                = "sub-nsg-gtw"
  location            = var.location
  resource_group_name = var.resource_group_name
  depends_on = [ data.azurerm_subnet.sub-gateway]
}

# Allow required inbound traffic on App Gateway NSG
resource "azurerm_network_security_rule" "app_gateway_inbound" {
  name                        = "allow-appgw-inbound"
  priority                    = 1001
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.sub-nsg-gtw.name
  depends_on = [ azurerm_network_security_group.sub-nsg-gtw ]
}

resource "azurerm_subnet" "frontend" {
  name                 = "frontend"
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.vnet_prd_name
  address_prefixes     = ["10.102.3.0/24"]
depends_on = [ data.azurerm_virtual_network.vnet-prd ]
}

resource "azurerm_public_ip" "gateway-public-ip" {
  name                = "gateway-public-ip"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Static"
  sku                 = "Standard"

}

# local variables for current config if we want to make rule path based -- current state if off
locals {
  backend_address_pool_name      = "${var.vnet_prd_name}-beap"
  frontend_port_name             = "${var.vnet_prd_name}-feport"
  frontend_ip_configuration_name = "${var.vnet_prd_name}-feip"
  http_setting_name              = "${var.vnet_prd_name}-be-htst"
  listener_name                  = "${var.vnet_prd_name}-httplstn"
  request_routing_rule_name      = "${var.vnet_prd_name}-rqrt"
  redirect_configuration_name    = "${var.vnet_prd_name}-rdrcfg"
   path_rule_name = "${var.vnet_prd_name}path_rule"
  url_path_map_name = "${var.vnet_prd_name}_url_path_jn_map"
  path_rule_wp_name = "${var.vnet_prd_name}path_wp_rule"
   path_rule_jn_name = "${var.vnet_prd_name}path_jn_rule"
   url_path_map_wp_name = "${var.vnet_prd_name}_url_path_wp_map"
  url_path_map_jn_name = "${var.vnet_prd_name}_url_path_jn_map"
}
resource "azurerm_application_gateway" "app-gtw-prd" {
  name                = "app-gtw-prd"
  resource_group_name = var.resource_group_name
  location            = var.location
  # firewall_policy_id                = azurerm_web_application_firewall_policy.f
  # force_firewall_policy_association = true

  sku {
    name     = "WAF_v2"
    tier     = "WAF_v2"
    capacity = 2
  }
   waf_configuration {
    firewall_mode            = "Prevention"
    rule_set_type            = "OWASP"
    rule_set_version         = "3.1"
    enabled                  = true
    max_request_body_size_kb = "128"
    file_upload_limit_mb     = "750"
   }
  gateway_ip_configuration {
    name      = "my-gateway-ip-configuration"
    subnet_id = azurerm_subnet.frontend.id
  }

  frontend_port {
    name = local.frontend_port_name
    port = 80
  }

  frontend_ip_configuration {
    name                 = local.frontend_ip_configuration_name
    public_ip_address_id = azurerm_public_ip.gateway-public-ip.id
    
  }

  backend_address_pool {
    name = local.backend_address_pool_name
  }

  backend_http_settings {
    name                  = local.http_setting_name
    cookie_based_affinity = "Disabled"
    path                  = "/"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 60
  }

  # backend_http_settings {
  #   name                  = "jenkins-http-settings"
  #   cookie_based_affinity = "Disabled"
  #   path                  = "/jenkins/"
  #   port                  = 80
  #   protocol              = "Http"
  #   request_timeout       = 60
  # }

  http_listener {
    name                           = local.listener_name
    frontend_ip_configuration_name = local.frontend_ip_configuration_name
    frontend_port_name             = local.frontend_port_name
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = local.request_routing_rule_name
    priority                   = 9
    rule_type                  = "Basic"
    http_listener_name         = local.listener_name
    backend_address_pool_name  = local.backend_address_pool_name
    backend_http_settings_name = local.http_setting_name
  }
  depends_on = [ data.azurerm_virtual_network.vnet-prd ]
}

