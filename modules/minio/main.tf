terraform {
  backend "gcs" {}
}

variable "secrets_dir" {}

module "minio" {
  source           = "/exekube-modules/helm-release"
  tiller_namespace = "kube-system"
  client_auth      = "${var.secrets_dir}/kube-system/helm-tls"

  release_name      = "minio"
  release_namespace = "default"

  chart_repo    = "stable"
  chart_name    = "minio"
  chart_version = "1.3.0"
}
