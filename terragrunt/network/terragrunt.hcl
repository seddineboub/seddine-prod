include "root"{
path = find_in_parent_folders()
}

terraform{
    source="../../terraform/network/"
}

dependency "infrastructure" {
  config_path = "../infrastructure"
}

# dependency "keyvault" {
#   config_path = "../keyvault"
# }



inputs = {
  vnet_prd_name      = dependency.infrastructure.outputs.vnet_prd_name
  location           = dependency.infrastructure.outputs.location
  resource_group_name = dependency.infrastructure.outputs.resource_group_name

  # input_from_remote_state = data.terraform_remote_state.hub-peer-prd.outputs.example_output
}

