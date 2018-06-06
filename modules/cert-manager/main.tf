terraform {
  backend "gcs" {}
}

variable "secrets_dir" {}

# module "cert_manager" {
#   source           = "/exekube-modules/helm-release"
#   tiller_namespace = "kube-system"
#   client_auth      = "${var.secrets_dir}/kube-system/helm-tls"
#
#   release_name      = "cert-manager"
#   release_namespace = "kube-system"
#
#   chart_repo    = "stable"
#   chart_name    = "cert-manager"
#   chart_version = "v0.3.1"
# }

resource "null_resource" "cert_manager_resources" {
  depends_on = ["module.cert_manager"]

  provisioner "local-exec" {
    # command = "kubectl apply -f ${path.module}/resources/"

    command = "kubectl -n default apply -f ${var.secrets_dir}/default/apps-ingress-tls-wildcard.yaml"
  }

  provisioner "local-exec" {
    when = "destroy"

    # command = "kubectl delete -f ${path.module}/resources/"

    command = "kubectl -n default delete -f ${var.secrets_dir}/default/apps-ingress-tls-wildcard.yaml"
  }

  # provisioner "local-exec" {
  #   command = "kubectl apply -f ${path.module}/resources/"
  #
  #   command = "kubectl -n monitoring apply -f ${var.secrets_dir}/default/apps-ingress-tls.yaml"
  # }
}

# resource "null_resource" "cert-manager-clouddns-secret" {
#   provisioner "local-exec" {
#     command = <<EOF
# kubectl create secret generic cert-manager-clouddns \
# --namespace kube-system \
# --from-file ${var.secrets_dir}/kube-system/cert-manager-clouddns.json
# EOF
#   }
#
#   provisioner "local-exec" {
#     when = "destroy"
#
#     command = <<EOF
# kubectl delete secret cert-manager-clouddns \
# --namespace kube-system
# EOF
#   }
# }

