# # ↓ Module metadata
#
# terragrunt = {
#   terraform {
#     source = "/project/modules//gogs"
#   }
#
#   dependencies {
#     paths = [
#       "../../kube-system/nginx-ingress",
#     ]
#   }
#
#   include = {
#     path = "${find_in_parent_folders()}"
#   }
# }
#
# domain_name = "dev.app2.apps.exekube.us"

