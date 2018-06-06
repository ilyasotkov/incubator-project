# ↓ Module metadata

terragrunt = {
  terraform {
    source = "/project/modules//iam"
  }

  include = {
    path = "${find_in_parent_folders()}"
  }
}

# ↓ Module configuration (empty means all default)

