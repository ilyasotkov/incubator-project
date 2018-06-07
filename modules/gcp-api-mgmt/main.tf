terraform {
  backend "gcs" {}
}

variable "project_id" {}
variable "serviceaccount_key" {}

variable "services" {
  description = "Google APIs to enable for this GCP project"

  default = [
    "compute.googleapis.com",
    "container.googleapis.com",
    "containerregistry.googleapis.com",
    "cloudkms.googleapis.com",
    "dns.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "iam.googleapis.com",
  ]
}

provider "google" {
  project     = "${var.project_id}"
  credentials = "${var.serviceaccount_key}"
}

# ------------------------------------------------------------------------------
# MANAGE GOOGLE CLOUD APIS
# ------------------------------------------------------------------------------

resource "google_project_service" "project_service" {
  count   = "${length(var.services)}"
  service = "${element(var.services, count.index)}"

  disable_on_destroy = false

  provisioner "local-exec" {
    command = "sleep 60"
  }
}
