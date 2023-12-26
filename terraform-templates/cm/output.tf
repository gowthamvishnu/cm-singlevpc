output "vpc_id" {
  value = module.network.vpc_id
}


# output "app_vpc_id" {
#   value = module.network.app_vpc_id
# }
# output "nlb_private_subnet_ids" {
#   value = module.network.nlb_private_subnet_ids
# }
# output "alb_private_subnet_ids" {
#   value = module.network.alb_private_subnet_ids
# }
# output "ecs_private_subnet_ids" {
#   value = module.network.ecs_private_subnet_ids
# }
# output "redis_private_subnet_ids" {
#   value = module.network.redis_private_subnet_ids
# }
# output "rabbit_private_subnet_ids" {
#   value = module.network.rabbit_private_subnet_ids
# }
# output "nat_public_subnet_ids" {
#   value = module.network.nat_public_subnet_ids
# }
# output "kms_private_subnet_ids" {
#   value = module.network.kms_private_subnet_ids
# }
# output "lambda_private_subnet_ids" {
#   value = module.network.lambda_private_subnet_ids
# }
# output "bastion_private_subnet_ids" {
#   value = module.network.bastion_private_subnet_ids
# }
# output "elk_private_subnet_ids" {
#   value = module.network.elk_private_subnet_ids
# }
# output "efs_private_subnet_ids" {
#   value = module.network.efs_private_subnet_ids
# }

# output "rds_vpc_id" {
#   value = module.network.rds_vpc_id
# }

# output "rds_private_subnet_ids" {
#   value = module.network.rds_private_subnet_ids
# }

# output "rds_subnet_group_name" {
#   value = module.network.subnet_group_name
# }

# output "nat_gateway_id" {
#   value = module.network.nat_gateway_id
# }

###########################################################################
# output "dmz_alb_dns_name" {
#   value = module.alb.dmz_alb_dns_name
# }
# output "dmz_alb_arn" {
#   value = module.alb.dmz_alb_arn
# }

output "app_alb_dns_name" {
  value = module.alb.app_alb_dns_name
}
output "app_alb_arn" {
  value = module.alb.app_alb_arn
}

#--------------------------------------------------------------------------
output "efs_file_system_id" {
  value = module.efs.efs_file_system_id
}

# output "bastion_private_ip" {
#   value = module.bastion.bastion_private_ip
# }

output "redis_cluster_arn" {
  value = module.redis.elasticache_cluster_arn
}

output "logstash_private_ip" {
  value = module.logstash.logstash_private_ip
}

output "lambda_function_arn" {
  value = module.lambda.lambda_function_arn
}

output "rds_cluster_arn" {
  value = module.rds.rds_cluster_arn
}

output "sns_topic_arn" {
  value = module.sns.sns_topic_arn
}

output "sqs_queue_arn" {
  value = module.sqs.sqs_queue_arn
}

output "elasticsearch_arn" {
  value = module.elasticsearch.elasticsearch_arn
}

output "ecs_cluster_arn" {
  value = module.ecs.ecs_cluster_arn
}

#---------------------------------------------------------------------------
output "api_gateway_url" {
  value = module.api_gateway.api_gateway_url
}

output "api_gateway_id" {
  value = module.api_gateway.api_gateway_id
}

# output "rabbit_mq_arn" {
#   value = module.rabbit.rabbit_arn
# }

# output "rabbit_mq_id" {
#   value = module.rabbit.rabbit_id
# }

# output "rabbit_config_arn" {
#   value = module.rabbit.rabbit_config_arn
# }

# output "rabbit_config_id" {
#   value = module.rabbit.rabbit_config_id
# }

# output "cm_app_public_key" {
#   value = module.ecs.cm_app_public_key
# }

# output "cm_utilities_public_key" {
#   value = module.ecs.cm_utilities_public_key
# }

# output "bastion_public_key" {
#   value = module.bastion.bastion_public_key
# }

# output "logstash_public_key" {
#   value = module.logstash.public_key
# }