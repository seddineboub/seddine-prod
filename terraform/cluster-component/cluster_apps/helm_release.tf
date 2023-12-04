provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"  
  }
}

resource "helm_release" "mariadb" {
  name       = "mariadb"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "mariadb"
  version    = "14.1.4"
  namespace  = "default"

  set {
    name  = "auth.rootPassword"
    value = "SeddinePass**"
  }
}

resource "helm_release" "wordpress" {
  name       = "wordpress"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "wordpress"
  version    = "18.1.20"
  namespace  = "default"

  set {
    name  = "wordpressUsername"
    value = "seddine"
  }

  set {
    name  = "wordpressPassword"
    value = "SeddinePass**"
  }

  set {
    name  = "mariadb.auth.rootPassword"
    value = "SeddinePass**"  
  }
}
