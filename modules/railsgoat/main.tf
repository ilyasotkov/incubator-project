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

  # kubernetes_yaml = [
  #   "${var.secrets_dir}/kube-system/cloudsql-db-credentials.yaml",
  # ]

  chart_name = "railsgoat/"
}

# resource "null_resource" "gcloud_sqlproxy_secret" {
#   provisioner "local-exec" {
#     command = <<EOF
# kubectl create secret generic railsgoat-gcloud-sqlproxy \
# --namespace default \
# --from-file credentials.json=${var.secrets_dir}/kube-system/cloudsql-client.json
# EOF
#   }
#
#   provisioner "local-exec" {
#     when    = "destroy"
#     command = "kubectl delete secret railsgoat-gcloud-sqlproxy"
#   }
# }

