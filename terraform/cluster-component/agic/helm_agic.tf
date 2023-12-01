# # helm_agic.tf
# resource "helm_release" "agic" {
#   name       = "agic"
#   repository = "/c/elo-network-git/elo-helm/Charts/agic"
#   chart      = "ingress-azure"
#   namespace  = "cluster-apps"
#   values     = [templatefile("${path.module}/agic_values.yml.tpl", {})]
# }



# resource "helm_release" "agic" {
#   name       = "agic"
#   repository = "/c/elo-network-git/elo-helm/Charts/agic"
#   chart      = "/c/elo-network-git/elo-helm/Charts/agic"
#   namespace  = "cluster-apps"
#   values     = [ "/c/elo-network-git/elo-helm/Charts/agic/values.yaml" ]
# }

