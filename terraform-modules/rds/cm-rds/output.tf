# output "rds_cluster_endpoint" {
#   description = "The endpoint (DNS address) of the RDS Aurora cluster"
#   value       = aws_rds_cluster.activepassive.endpoint
# }

# output "rds_cluster_read_endpoints" {
#   description = "List of read-only endpoints for the RDS Aurora cluster instances"
#   value       = [for instance in aws_rds_cluster_instance.cluster_instances : instance.endpoint]
# }

# output "rds_cluster_arn" {
# value = aws_rds_cluster.activepassive.arn
# }


output "rds_cluster_endpoint" {
  description = "The endpoint (DNS address) of the RDS Aurora cluster"
  value       = aws_rds_cluster.activepassive.endpoint
}

output "rds_cluster_read_endpoints" {
  description = "List of read-only endpoints for the RDS Aurora cluster instances"
  value       = [for instance in aws_rds_cluster_instance.cluster_instances : instance.endpoint]
}

output "rds_cluster_arn" {
value = aws_rds_cluster.activepassive.arn
}
