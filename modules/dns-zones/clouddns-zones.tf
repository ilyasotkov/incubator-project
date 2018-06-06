terraform {
  backend "gcs" {}
}

variable "project_id" {}
variable "serviceaccount_key" {}

provider "google" {
  project     = "${var.project_id}"
  credentials = "${var.serviceaccount_key}"
}

resource "google_dns_managed_zone" "auto_dns_exekube_us" {
  name     = "auto-dns-exekube-us"
  dns_name = "auto-dns.exekube.us."
}

output "dns_ns_servers" {
  value = ["${google_dns_managed_zone.auto_dns_exekube_us.name_servers}"]
}

# # Configure the Namecheap provider
## NOT YET SUPPORTED (unable to access namecheap API due to its limits)
# provider "namecheap" {
#   username    = "${var.namecheap_username}"
#   api_user    = "${var.namecheap_apiuser}"
#   token       = "${var.namecheap_token}"
#   ip          = "${var.namecheap_ip}"
#   use_sandbox = false
# }
#
# # Add a record to the domain
# resource "namecheap_record" "foobar" {
#   domain  = "${var.namecheap_domain}"
#   name    = "www"
#   address = "ns-cloud-c1.googledomains.com."
#   type    = "NS"
# }

