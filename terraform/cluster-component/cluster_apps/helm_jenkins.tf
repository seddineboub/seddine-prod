# resource "helm_release" "jenkins" {
#   name       = "jenkins"
#   //repository = "/home/seddine/elo-helm/jenkins/"  
#   chart      = "/home/seddine/elo-helm/jenkins/"    
#   //values     = [ "/home/seddine/elo-helm/jenkins/values.yaml" ]  

resource "helm_release" "yaml_file_1" {
  chart   = "/home/seddine/elo-helm/jenkins"
  name    = "jenkins"
  version = "1"

  cleanup_on_fail = true

  values = [templatefile("${path.module}/jenkins.values.yml.tpl", {
    rg = var.resource_group_name
    location = var.location
  })]
}