# ↓ Module metadata
terragrunt = {
  terraform {
    source = "/project/modules//ark"
  }

  dependencies {
    paths = [
      "../administration-tasks",
    ]
  }

  include = {
    path = "${find_in_parent_folders()}"
  }
}

# ↓ Module configuration (empty means all default)
