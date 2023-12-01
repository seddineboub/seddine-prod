include "root"{
path = find_in_parent_folders()
}

terraform{
    source="../../terraform/keyvault/"
}

dependency "infrastructure" {
  config_path = "../infrastructure"
}


inputs = {
  vnet_prd_name      = dependency.infrastructure.outputs.vnet_prd_name
  location           = dependency.infrastructure.outputs.location
  resource_group_name = dependency.infrastructure.outputs.resource_group_name
  tenant_id           ="84f1e4ea-8554-43e1-8709-f0b8589ea118"
}
