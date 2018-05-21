terraform {
  backend "gcs" {}
}

variable "secrets_dir" {}

module "snapshot_controller" {
  source           = "/exekube-modules/helm-release"
  tiller_namespace = "kube-system"
  client_auth      = "${var.secrets_dir}/kube-system/helm-tls"

  release_name      = "snapshot"
  release_namespace = "kube-system"

  chart_name = "snapshot-controller/"
}
