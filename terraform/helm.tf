provider "helm" {
  kubernetes {
    host                   = module.ping-pong.cluster_endpoint
    cluster_ca_certificate = base64decode(module.ping-pong.cluster_certificate_authority_data)
    token                  = data.aws_eks_cluster_auth.ping-pong.token
  }
}

resource "helm_release" "prometheus" {
  name = "prometheus"

  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  version    = "43.2.1"
  namespace  = "monitor"

  set {
    name  = "grafana.enabled"
    value = "false"
  }
}

resource "helm_release" "grafana" {
  name = "grafana"

  repository = "https://grafana.github.io/helm-charts"
  chart      = "grafana"
  version    = "6.56.1"
  namespace  = "monitor"

  set {
    name  = "persistence.enabled"
    value = "true"
  }
  set {
    name  = "persistence.type"
    value = "pvc"
  }
  set {
    name  = "persistence.size"
    value = "10Gi"
  }
}