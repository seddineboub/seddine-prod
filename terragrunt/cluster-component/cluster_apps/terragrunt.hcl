include "root"{
path = find_in_parent_folders()
}
terraform{
    source="../../../terraform/cluster-component/cluster_apps/"
}
# terraform{
#     source="../../../terraform/cluster-component/cluster_apps/jenkins/"
# }
# terraform{
#     source="../../../terraform/cluster-component/cluster_apps/jenkins/"
# }

# dependency "agic" {
#   config_path = "../agic/"
# }

inputs= {
 location            = "West US"
  resource_group_name = "1-e967b1c4-playground-sandbox"
}


