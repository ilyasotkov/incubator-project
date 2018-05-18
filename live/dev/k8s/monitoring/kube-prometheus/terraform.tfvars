# ↓ Module metadata

terragrunt = {
  terraform {
    source = "/project/modules//kube-prometheus"
  }

  dependencies {
    paths = [
      "../../kube-system/administration-tasks",
      "../prometheus-operator",
    ]
  }

  include = {
    path = "${find_in_parent_folders()}"
  }
}
