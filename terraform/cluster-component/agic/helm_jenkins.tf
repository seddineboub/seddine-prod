# helm_agic.tf
resource "helm_release" "jenkins" {
  name       = "jenkins"
  repository = "/c/elo-network-git/elo-helm/Charts/agic"
  chart      = "ingress-azure"
  namespace  = "cluster-apps"
  values     = [templatefile("${path.module}/agic_values.yml.tpl", {})]
}