
# resource "helm_release" "yaml_file_2" {
#   chart   = "/home/seddine/elo-helm/wordpress"
#   name    = "wordpress"
#   version = "1"

#   cleanup_on_fail = true

#   values = [templatefile("${path.module}/wp.values.yml.tpl", {
#     rg = var.resource_group_name
#     location = var.location
#   })]
# }

# resource "helm_release" "mysql" {
#  name  = "mysql"
#  chart = "${abspath(path.root)}/home/seddine/elo-helm/charts/mysql-chart"
# }
# resource "helm_release" "wordpress" {
#  name  = "wordpress"
#  chart = "${abspath(path.root)}/home/seddine/elo-helm/charts/wordpress-chart"
# }