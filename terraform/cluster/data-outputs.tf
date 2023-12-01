data "azurerm_client_config" "current" {}

output "account_id" {
  value = "${data.azurerm_client_config.current.client_id}"
}
output "tenant_id" {
  value = "${data.azurerm_client_config.current.tenant_id}"
}
output "subscription_id" {
  value = "${data.azurerm_client_config.current.subscription_id }"
}

# output "service_principal_application_id" {
#   value = "${data.azurerm_client_config.current.service_principal_application_id}"
# }

# output "service_principal_object_id" {
#   value = "${data.azurerm_client_config.current.service_principal_object_id}"
# }