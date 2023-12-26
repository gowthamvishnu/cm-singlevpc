# data "template_file" "userdata" {
#   template = filebase64("${path.module}/user_data.sh")
#   vars = {
#     ECS_CLUSTER = var.cluster_name
#   }
# }
