provider "helm" {}

terraform {
  backend "gcs" {}
}

variable "secrets_dir" {}

module "kube_prometheus" {
  source           = "/exekube-modules/helm-release"
  tiller_namespace = "kube-system"
  client_auth      = "${var.secrets_dir}/kube-system/helm-tls"

  release_name   = "kp"
  release_values = "values.yaml"
  extra_values   = "env.yaml"

  release_namespace = "monitoring"

  chart_repo    = "coreos"
  chart_name    = "kube-prometheus"
  chart_version = "0.0.68"
}
