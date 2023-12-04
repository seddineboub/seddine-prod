//auto generated based on 1 init 

// Generating Provider for as global config - Azure
generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "azurerm" {
  features {}
    skip_provider_registration = true
}
EOF
}

// Generating Backend for as global config - Azure
remote_state {
  backend = "azurerm"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }
  config = {
    resource_group_name  = "1-e967b1c4-playground-sandbox"
    storage_account_name = "storeelonetwork" // store elonetwork - need storage space created first
    container_name       = "containerst" //  CONTAINER ST
    key                  = "${path_relative_to_include()}/prod.tfstate"
  }
}

//----------------------------------------------------------------------

// Generale config as needed to be global
# inputs = {
#   location = ""
#   resource_group_name = ""
# }

//----------------------------------------------------------------------

# #LOCAL VARIABLES AND ENVIREMENT ON EACH LEVEL
# locals {
# environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
# }
# inputs = merge(
#  local.environment_vars.locals,
# )

