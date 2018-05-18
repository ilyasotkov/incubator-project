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

resource "google_storage_bucket" "ark" {
  name          = "${var.project_id}-ark"
  force_destroy = true
  location      = "EU"
}

resource "google_service_account" "ark" {
  account_id = "heptio-ark"
}

resource "null_resource" "ark_key" {
  provisioner "local-exec" {
    command = <<EOF
gcloud iam service-accounts keys create \
--iam-account ${google_service_account.ark.email} \
${var.secrets_dir}/kube-system/credentials-ark
EOF
  }
}

resource "google_project_iam_custom_role" "ark" {
  role_id     = "ark.server"
  title       = "Heptio Ark Server"
  description = "Role for Heptio Ark Server"

  permissions = [
    "compute.disks.get",
    "compute.disks.create",
    "compute.disks.createSnapshot",
    "compute.snapshots.get",
    "compute.snapshots.create",
    "compute.snapshots.useReadOnly",
    "compute.snapshots.delete",
    "compute.projects.get",
  ]
}

resource "google_project_iam_binding" "ark" {
  project = "${var.project_id}"
  role    = "projects/${var.project_id}/roles/${google_project_iam_custom_role.ark.role_id}"

  members = [
    "serviceAccount:${google_service_account.ark.email}",
  ]
}

resource "google_storage_bucket_iam_binding" "ark" {
  bucket = "${google_storage_bucket.ark.name}"
  role   = "roles/storage.objectAdmin"

  members = [
    "serviceAccount:${google_service_account.ark.email}",
  ]
}
