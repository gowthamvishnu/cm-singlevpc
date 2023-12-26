# output "elasticache_cluster_arn" {
#   value = aws_elasticache_cluster.example.arn
# }

# output "elasticache_subnets_group_name" {
#   value = aws_elasticache_subnet_group.elasticache_subnets.name
# }

output "elasticache_cluster_arn" {
  value = aws_elasticache_replication_group.elasticache.arn
}

output "elasticache_subnets_group_name" {
  value = aws_elasticache_subnet_group.elasticache_subnets.name
}

