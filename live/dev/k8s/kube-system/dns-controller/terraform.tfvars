# ↓ Module metadata

terragrunt = {
  terraform {
    source = "/project/modules//dns-controller"
  }

  dependencies {
    paths = [
      "../nginx-ingress",
    ]
  }

  include = {
    path = "${find_in_parent_folders()}"
  }
}

# ↓ Module configuration (empty means all default)

