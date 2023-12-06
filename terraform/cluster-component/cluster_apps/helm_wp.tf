
resource "helm_release" "yaml_file_2" {
  chart   = "/home/seddine/elo-helm/wpp"
  name    = "wordpress"
  version = "1"

  cleanup_on_fail = true

  values = [templatefile("${path.module}/wp.values.yml.tpl", {
    rg = var.resource_group_name
    location = var.location
  })]
}
