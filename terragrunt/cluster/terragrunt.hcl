include "root"{
path = find_in_parent_folders()
}

terraform{
    source="../../terraform/cluster/"
}

dependency "infrastructure" {
  config_path = "../infrastructure"
    # skip_outputs = true
}
# dependency "network" {
#   config_path = "../network"
# }
# dependency "keyvault" {
#   config_path = "../keyvault"
# }

inputs = {
#  vnet_prd_id   = dependency.infrastructure.outputs.vnet_prd_id
  vnet_prd_name      = dependency.infrastructure.outputs.vnet_prd_name
  location           = dependency.infrastructure.outputs.location
  resource_group_name = dependency.infrastructure.outputs.resource_group_name
  address_space       = ["10.102.0.0/16"]
  # client_id             = dependency.keyvault.outputs.client_id
  # client_secret      =   dependency.keyvault.outputs.client_secret


  //for service principle in order to use private dns zone
 #client_id     = "c2dfb81f-509a-4f0e-87f7-db1ff8710bdd" 
 #client_secret = "0NE8Q~Cd3eJ6mLCQAIZZO8C.muf4.X7ebGtVPbIS"
}
