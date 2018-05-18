# ↓ Module metadata

terragrunt = {
  terraform {
    source = "/project/modules//prometheus-operator"
  }

  dependencies {
    paths = [
      "../../kube-system/administration-tasks",
    ]
  }

  include = {
    path = "${find_in_parent_folders()}"
  }
}
