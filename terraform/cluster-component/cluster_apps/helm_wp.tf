# resource "helm_release" "jenkins" {
#   name       = "jenkins"
#   //repository = "/home/seddine/elo-helm/jenkins/"  
#   chart      = "/home/seddine/elo-helm/jenkins/"    
#   //values     = [ "/home/seddine/elo-helm/jenkins/values.yaml" ]  

resource "helm_release" "yaml_file_2" {
  chart   = "/home/seddine/elo-helm/wordpress"
  name    = "wordpress"
  version = "1"

  cleanup_on_fail = true

  values = [templatefile("${path.module}/wp.values.yml.tpl", {
    rg = var.resource_group_name
    location = var.location
  })]
}