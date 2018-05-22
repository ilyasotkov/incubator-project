terraform {
  backend "gcs" {}
}

variable "secrets_dir" {}

module "sparkoperator" {
  source           = "/exekube-modules/helm-release"
  tiller_namespace = "kube-system"
  client_auth      = "${var.secrets_dir}/kube-system/helm-tls"

  release_name      = "sparkoperator"
  release_namespace = "sparkoperator"

  chart_name = "sparkoperator/"
}
