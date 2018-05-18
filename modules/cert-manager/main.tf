terraform {
  backend "gcs" {}
}

variable "secrets_dir" {}

module "cert_manager" {
  source           = "/exekube-modules/helm-release"
  tiller_namespace = "kube-system"
  client_auth      = "${var.secrets_dir}/kube-system/helm-tls"

  release_name      = "cert-manager"
  release_namespace = "kube-system"

  chart_repo    = "stable"
  chart_name    = "cert-manager"
  chart_version = "0.2.8"
}

resource "null_resource" "cert_manager_resources" {
  depends_on = ["module.cert_manager"]

  provisioner "local-exec" {
    # command = "kubectl apply -f ${path.module}/resources/"

    command = "kubectl -n default apply -f ${var.secrets_dir}/default/apps-ingress-tls.yaml"
  }

  provisioner "local-exec" {
    # command = "kubectl apply -f ${path.module}/resources/"

    command = "kubectl -n monitoring apply -f ${var.secrets_dir}/default/apps-ingress-tls.yaml"
  }

  provisioner "local-exec" {
    when = "destroy"

    # command = "kubectl delete -f ${path.module}/resources/"

    command = "kubectl -n default delete -f ${var.secrets_dir}/default/apps-ingress-tls.yaml"
  }
}
