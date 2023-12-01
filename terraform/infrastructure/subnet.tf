
### - Create subnets -------------------------------**
# reserverd for aks
  resource "azurerm_subnet" "sub-aks" {
    name                 = var.sub-aks
    resource_group_name  = var.resource_group_name
    virtual_network_name = azurerm_virtual_network.vnet-prd.name
    address_prefixes     = ["10.102.1.0/24"]  
    depends_on = [ azurerm_virtual_network.vnet-prd ]
  }
# reserved for app gate way 
 resource "azurerm_subnet" "sub-gateway" {
    name                 = "sub-gateway"
    resource_group_name  = var.resource_group_name
    virtual_network_name = azurerm_virtual_network.vnet-prd.name
    address_prefixes     = ["10.102.2.0/24"]  
    depends_on = [ azurerm_virtual_network.vnet-prd ]
  }

   resource "azurerm_subnet" "sub-agent" {
    name                 = "sub-agent"
    resource_group_name  = var.resource_group_name
    virtual_network_name = azurerm_virtual_network.vnet-prd.name
    address_prefixes     = ["10.102.4.0/24"]  
    depends_on = [ azurerm_virtual_network.vnet-prd ]
  }
//---------------------------------------------end

 