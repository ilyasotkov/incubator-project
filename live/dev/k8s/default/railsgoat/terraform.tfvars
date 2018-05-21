# ↓ Module metadata

terragrunt = {
  terraform {
    source = "/project/modules//railsgoat"
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

domain_name = "dev.railsgoat.apps.exekube.us"
