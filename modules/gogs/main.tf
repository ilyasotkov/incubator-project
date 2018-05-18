terraform {
  backend "gcs" {}
}

variable "secrets_dir" {}
variable "domain_name" {}

module "gogs" {
  source = "/exekube-modules/helm-release"

  tiller_namespace = "kube-system"
  client_auth      = "${var.secrets_dir}/kube-system/helm-tls"

  release_name      = "gogs"
  release_namespace = "default"
  domain_name       = "${var.domain_name}"

  chart_repo    = "incubator"
  chart_name    = "gogs"
  chart_version = "0.5.3"
}
