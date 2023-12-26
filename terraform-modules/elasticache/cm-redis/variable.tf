# variable "elasticache_cluster_type" {
#   description = "The Cluster Type for Elasticache"
# }

# variable "elasticache_node_type" {
#   description = "The Node type for Elasticache Redis Cluster"
#   type        = string
# }
# variable "elasticache_engine" {
#   description = "The Engine type for Elasticache"
# }
# variable "elasticache_engine_version" {
#   description = "Engine Version for Elasticache"
# }
# variable "elasticache_parameter_group_name" {
#   description = "Parameter Group Name for Elasticache"
# }

# variable "elasticache_subnet_ids" {
#   description = "The ID of the subnet for the Elasticache Redis Cluster"
#   type        = string
# }
# variable "elasticache_security_group_ids" {
#   description = "The security group for Elasticache Redis Cluster."
#   type        = list(string)
# }
# variable "RoleArn" {
#   description = "ACCOUNT ROLE ARN FOR ALL OTHER RESOURCES"
# }
# variable "DBRoleArn" {
#   description = "RDS ACCOUNT ROLE ARN"
# }
variable "elasticache_cluster_type" {
  description = "The Cluster Type for Elasticache"
}

variable "elasticache_node_type" {
  description = "The Node type for Elasticache Redis Cluster"
  type        = string
}
variable "elasticache_engine" {
  description = "The Engine type for Elasticache"
}
variable "elasticache_engine_version" {
  description = "Engine Version for Elasticache"
}
variable "elasticache_parameter_group_name" {
  description = "Parameter Group Name for Elasticache"
}

variable "elasticache_subnet_ids" {
  description = "The ID of the subnet for the Elasticache Redis Cluster"
  type        = list(string)
}
variable "elasticache_security_group_ids" {
  description = "The security group for Elasticache Redis Cluster."
  type        = list(string)
}
variable "RoleArn" {
  description = "ACCOUNT ROLE ARN FOR ALL OTHER RESOURCES"
}
variable "DBRoleArn" {
  description = "RDS ACCOUNT ROLE ARN"
}

variable "elasticache_port" {
  description = "The port number on which each of the cache nodes will accept connections"
}

variable "num_node_groups" {
  description = "Number of node groups (shards) for this Redis replication group"
}

variable "replicas_per_node_group" {
  description = "Number of replica nodes in each node group"
}

variable "transit_encryption_enabled" {
  description = "Whether to enable encryption in transit"
  type = bool
}

variable "at_rest_encryption_enabled" {
  description = "Whether to enable encryption at rest"
  type = bool
}

variable "auth_token" {
  description = "Password used to access a password protected server"
}

# variable "auth_token_update_strategy" {
#   description = "Strategy to use when updating the auth_token"
# }

#--------------------------------------------------------------------------
variable "environment" {
  type        = string
  description = "Name of the env"
}

variable "aws_region" {
  description = "The AWS region to create things in."
}

variable "requestor" {
  description = "Email ID of the requestor"
}

variable "customer" {
  description = "Name of the customer"
}

variable "tenant" {
  description = "tenant type"
}

variable "product" {
  description = "Name of the Product"
}

variable "manager" {
  description = "Email ID of the manager"
}

variable "owner" {
  description = "Email ID of the Owner"
}

variable "purpose" {
  description = "Purpose type"
}