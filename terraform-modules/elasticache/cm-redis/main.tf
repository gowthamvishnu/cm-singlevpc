locals {
    tags = {
    "environment" = "${var.environment}",
    "Region" = "${var.aws_region}",
    "requestor" = "${var.requestor}",
    "customer" = "${var.customer}",
    "tenant" = "${var.tenant}",
    "product" = "${var.product}",
    "manager" = "${var.manager}",
    "owner" = "${var.owner}",
    "purpose" = "${var.purpose}"
  }
}

# resource "aws_elasticache_cluster" "example" {
#   cluster_id           = "${var.product}-${var.environment}-${var.elasticache_cluster_type}"
#   engine               = var.elasticache_engine
#   node_type            = var.elasticache_node_type
#   num_cache_nodes      = 1
#   parameter_group_name = var.elasticache_parameter_group_name #"default.redis3.2"
#   engine_version       = var.elasticache_engine_version
#   port                 = 6379
#   subnet_group_name    = aws_elasticache_subnet_group.elasticache_subnets.name
#   security_group_ids   = var.elasticache_security_group_ids

#   tags = merge(
#     local.tags, {"Name" = "${var.product}-${var.environment}-${var.elasticache_cluster_type}"}
#   )
# }

# resource "aws_elasticache_subnet_group" "elasticache_subnets" {
#   name       = "${var.customer}-${var.environment}-${var.product}-${var.elasticache_cluster_type}-subnet-group"
#   subnet_ids = [var.elasticache_subnet_ids]

#   tags = merge(
#     local.tags, {"Name" = "${var.customer}-${var.environment}-${var.product}-${var.elasticache_cluster_type}-subnet-group"}
#   )
# }
# resource "aws_elasticache_cluster" "example" {
#   cluster_id           = "${var.product}-${var.environment}-${var.elasticache_cluster_type}"
#   engine               = var.elasticache_engine
#   node_type            = var.elasticache_node_type
#   num_cache_nodes      = 1
#   parameter_group_name = var.elasticache_parameter_group_name #"default.redis3.2"
#   engine_version       = var.elasticache_engine_version
#   port                 = 6379
#   subnet_group_name    = aws_elasticache_subnet_group.elasticache_subnets.name
#   security_group_ids   = var.elasticache_security_group_ids

#   tags = merge(
#     local.tags, {"Name" = "${var.product}-${var.environment}-${var.elasticache_cluster_type}"}
#   )
# }


resource "aws_elasticache_replication_group" "elasticache" {
  replication_group_id       = "${var.product}-${var.environment}-${var.elasticache_cluster_type}"
  description                = "elasticache_replication_group"
  engine                     = var.elasticache_engine
  engine_version             = var.elasticache_engine_version
  node_type                  = var.elasticache_node_type #"cache.t2.small"
  port                       = var.elasticache_port #6379
  parameter_group_name       = var.elasticache_parameter_group_name #"default.redis3.2.cluster.on"
  subnet_group_name          = aws_elasticache_subnet_group.elasticache_subnets.name
  security_group_ids         = var.elasticache_security_group_ids
  automatic_failover_enabled = true
  multi_az_enabled           = true
  num_node_groups            = var.num_node_groups
  replicas_per_node_group    = var.replicas_per_node_group
  at_rest_encryption_enabled = var.at_rest_encryption_enabled
  transit_encryption_enabled = var.transit_encryption_enabled
  auth_token                 = var.auth_token
  #auth_token_update_strategy = var.auth_token_update_strategy

  tags = merge(
    local.tags, {"Name" = "${var.product}-${var.environment}-${var.elasticache_cluster_type}"}
  )
}


resource "aws_elasticache_subnet_group" "elasticache_subnets" {
  name       = "${var.product}-${var.environment}-${var.elasticache_cluster_type}-subnet-group"
  subnet_ids = var.elasticache_subnet_ids

  tags = merge(
    local.tags, {"Name" = "${var.product}-${var.environment}-${var.elasticache_cluster_type}-subnet-group"}
  )
}
