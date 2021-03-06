# ↓ Module metadata

terragrunt = {
  terraform {
    source = "/project/modules//guestbook"
  }

  dependencies {
    paths = [
      "../../kube-system/cert-manager",
    ]
  }

  include = {
    path = "${find_in_parent_folders()}"
  }
}

# ↓ Module configuration (empty means all default)

domain_name = "guestbook.auto-dns.exekube.us"
