terraform {
  backend "gcs" {}
}

variable "secrets_dir" {}
variable "domain_name" {}

module "forms_app" {
  source           = "/exekube-modules/helm-release"
  tiller_namespace = "kube-system"
  client_auth      = "${var.secrets_dir}/kube-system/helm-tls"

  release_name      = "forms-app"
  release_namespace = "default"
  extra_values      = "values-env.yaml"

  chart_repo    = "exekube"
  chart_name    = "nginx-react"
  chart_version = "0.2.1"

  domain_name = "${var.domain_name}"
}
