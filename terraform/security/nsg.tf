
# ### - Create Network Security Groups -------------------------**
# #
# # NSG for firewall -- sub-firewall

#   # Create NSG
#   resource "azurerm_network_security_group" "sub-nsg-aks" {
#     name                = "sub-nsg-aks"
#     location = var.location
#     resource_group_name = var.resource_group_name
#   }


#   # # Associate NSG with Subnet
#   # resource "azurerm_subnet_network_security_group_association" "aks_subnet_nsg_association" {
#   #   subnet_id                 = azurerm_subnet.sub-aks.id
#   #   network_security_group_id = azurerm_network_security_group.sub-nsg-aks.id
#   # }

module "nsg_sub_aks_prod" {
  source              = "../modules/nsg/"
  subnet_id           = var.sub_aks_prod_id
  name                = var.nsg_sub_aks_prod_name
  nsg_location        = var.location
  resource_group_name = var.resource_group_name
}