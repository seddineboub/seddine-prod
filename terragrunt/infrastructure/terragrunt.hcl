include "root"{
path = find_in_parent_folders()
}
# locals {
#   # Automatically load environment-level variables
#   environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
# }

terraform{
    source="../../terraform/infrastructure/"
}


inputs = {
  vnet_hub_name       = "vnet-prd"
  address_space       = ["10.102.0.0/16"]
  location            = "West US"
  resource_group_name = "1-e967b1c4-playground-sandbox"
}
