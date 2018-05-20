terraform {
  backend "gcs" {}
}

variable "project_id" {}
variable "serviceaccount_key" {}
variable "secrets_dir" {}

output "instance_connection_name" {
  value = "${google_sql_database_instance.master.connection_name}"
}

provider "google" {
  project     = "${var.project_id}"
  credentials = "${var.serviceaccount_key}"
}

resource "google_project_service" "sqladmin" {
  service            = "sqladmin.googleapis.com"
  disable_on_destroy = false

  provisioner "local-exec" {
    command = "sleep 60"
  }
}

resource "google_sql_database_instance" "master" {
  depends_on = ["google_project_service.sqladmin"]

  name             = "master-instance"
  database_version = "POSTGRES_9_6"
  region           = "europe-west1"

  settings {
    tier      = "db-f1-micro"
    disk_size = "10"
  }
}

resource "google_sql_user" "proxyuser" {
  name     = "proxyuser"
  instance = "${google_sql_database_instance.master.name}"
  password = "${chomp(file("${var.secrets_dir}/default/cloudsql-proxyuser-password"))}"
}

resource "google_service_account" "cloudsql_client" {
  account_id = "cloudsql-client"
}

resource "null_resource" "cloudsql_client_key" {
  provisioner "local-exec" {
    command = <<EOF
gcloud iam service-accounts keys create \
--iam-account ${google_service_account.cloudsql_client.email} \
${var.secrets_dir}/kube-system/cloudsql-client.json
EOF
  }
}

resource "google_project_iam_binding" "cloudsql_client" {
  project = "${var.project_id}"
  role    = "roles/cloudsql.client"

  members = [
    "serviceAccount:${google_service_account.cloudsql_client.email}",
  ]
}
