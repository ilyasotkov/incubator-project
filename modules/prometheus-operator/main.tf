provider "helm" {}

terraform {
  backend "gcs" {}
}

variable "secrets_dir" {}

module "prometheus_operator" {
  source           = "/exekube-modules/helm-release"
  tiller_namespace = "kube-system"
  client_auth      = "${var.secrets_dir}/kube-system/helm-tls"

  release_name      = "po"
  release_namespace = "monitoring"

  chart_repo    = "${helm_repository.coreos.name}"
  chart_name    = "prometheus-operator"
  chart_version = "0.0.24"
}

resource "helm_repository" "coreos" {
  name = "coreos"
  url  = "https://s3-eu-west-1.amazonaws.com/coreos-charts/stable/"

  provisioner "local-exec" {
    command = "helm repo update"
  }
}
