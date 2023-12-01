# # Outputs for vnet
# output "vnet_prd_id" {
#   value = var.vnet_prd_name.id
# }



output "vnet_prd_name" {
  value = var.vnet_prd_name
}

output "location" {
  description = "vnet hub location"
  value = var.location
}


output "resource_group_name" {
  description = "resource groupe name"
  value = var.resource_group_name
}

output "sub-aks" {
  value = azurerm_subnet.sub-aks.id
}

output "sub_aks_prod_id" {
    value = azurerm_subnet.sub-aks.id
}

