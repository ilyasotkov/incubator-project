# ↓ Module metadata

terragrunt = {
  terraform {
    source = "/project/modules//concourse"
  }

  dependencies {
    paths = [
      "../../kube-system/nginx-ingress",
    ]
  }

  include = {
    path = "${find_in_parent_folders()}"
  }
}

domain_name = "dev.app1.apps.exekube.us"
