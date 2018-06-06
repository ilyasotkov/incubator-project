terraform {
  backend "gcs" {}
}

variable "secrets_dir" {}

module "external-dns" {
  source = "/exekube-modules/helm-release"

  tiller_namespace = "kube-system"
  client_auth      = "${var.secrets_dir}/kube-system/helm-tls"

  release_name      = "external-dns"
  release_namespace = "kube-system"

  chart_repo    = "stable"
  chart_name    = "external-dns"
  chart_version = "0.6.1"
}
