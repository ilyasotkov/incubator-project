terraform {
  backend "gcs" {}
}

variable "secrets_dir" {}
variable "domain_name" {}

module "railsgoat" {
  source           = "/exekube-modules/helm-release"
  tiller_namespace = "kube-system"
  client_auth      = "${var.secrets_dir}/kube-system/helm-tls"

  release_name      = "railsgoat"
  release_namespace = "default"
  domain_name       = "${var.domain_name}"

  chart_name = "railsgoat/"
}
