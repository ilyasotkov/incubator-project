terraform {
  backend "gcs" {}
}

variable "project_id" {}
variable "secrets_dir" {}

# module "ark" {
#   source = "/exekube-modules/helm-template-release"
#
#   release_name      = "ark"
#   release_namespace = "kube-system"
#
#   chart_name = "ark/"
#   project_id = "${var.project_id}"
# }
#
# resource "null_resource" "ark_credentials" {
#   provisioner "local-exec" {
#     command = <<EOF
# kubectl create secret generic cloud-credentials \
# --namespace heptio-ark \
# --from-file cloud=${var.secrets_dir}/kube-system/credentials-ark
# EOF
#   }
# }


# resource "null_resource" "data_backup" {
#   provisioner "local-exec" {
#     command = <<EOF
# ark create schedule data-backup \
# --schedule="*/30 * * * *" \
# --snapshot-volumes=true \
# --include-resources=pvcs,pvs
# EOF
#   }
# }

