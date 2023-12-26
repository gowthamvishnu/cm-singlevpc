output "ecs_cluster_id" {
  value = aws_ecs_cluster.app_cluster.id
}

output "ecs_cluster_arn" {
  value = aws_ecs_cluster.app_cluster.arn
}

# output "cm_app_public_key" {
#   value = tls_private_key.cm_app_lt_key.public_key_openssh
# }

# output "cm_utilities_public_key" {
#   value = tls_private_key.cm_utilities_lt_key.public_key_openssh
# }
