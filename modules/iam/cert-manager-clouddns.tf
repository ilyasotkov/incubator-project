variable "project_id" {}
variable "serviceaccount_key" {}
variable "secrets_dir" {}

terraform {
  backend "gcs" {}
}

provider "google" {
  project     = "${var.project_id}"
  credentials = "${var.serviceaccount_key}"
}

resource "google_service_account" "cert_manager_clouddns" {
  account_id = "cert-manager-clouddns"
}

resource "null_resource" "cert_manager_clouddns_key" {
  provisioner "local-exec" {
    command = <<EOF
gcloud iam service-accounts keys create \
--iam-account ${google_service_account.cert_manager_clouddns.email} \
${var.secrets_dir}/kube-system/cert-manager-clouddns.json
EOF
  }
}

resource "google_project_iam_binding" "cert_manager_clouddns" {
  project = "${var.project_id}"
  role    = "roles/dns.admin"

  members = [
    "serviceAccount:${google_service_account.cert_manager_clouddns.email}",
  ]
}
