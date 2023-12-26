# variable "create_waf" {
#   description = "Want to create WAF?"
#   type = bool
# }

# variable "existing_waf_name" {
#   description = "Enter the existing_waf_name"
# }
###################################################################################
####    CM_VPC VARS

variable "cm_vpc_id" {
  #type        = string
  description = "VPC ID of the Existing VPC"
}

variable "create_nat_gw" {
  description = "Create NAT Gateway or not (True/False)"
  type        = bool
}


variable "cm_vpc_cidr_block" {
  description = "VPC CIDR range Of the CM Vpc"
  type        = string
}
variable "existing_subnet_ids" {
  description = "Private subnet ID list to create a subnet attached with NG"
  type = list(string)
  #type = string
}

variable "create_subnets" {
  description  = "create subnets true or false"
  type = bool
}


variable "enable_dns_support" {
  description = "enable_dns_support"
  type        = bool
}

variable "enable_dns_hostnames" {
  description = "enable_dns_hostnames"
  type        = bool
}

variable "instance_tenancy" {
  description = "instance_tenancy"
}

variable "az_count" {
  description = "Availability Zone Count"
}

variable "redis_engine_version" {
  description = "Engine Version for Redis Cluster"
}
variable "redis_node_type" {
  description = "The Node Type for Redis Cluster"
  type        = string
}

variable "logstash_ami_id" {
  description = "AMI ID for Logstash Server"
}
variable "logstash_instance_type" {
  description = "The EC2 instance type"
  type        = string
}

variable "rabbit_instance_type" {
  description = "The EC2 instance type"
  type        = string
}
variable "rabbit_ami_id" {
  description = "AMI Id for rabbit instance"
}

# variable "bastion_ami_id" {
#   description = "AMI Id for Bastion Server"
# }
# variable "bastion_instance_type" {
#   description = "The EC2 instance type"
#   type        = string
# }

variable "ecs_lt_ami_id" {
  description = "AMI ID for Lunch Template for ECS Cluster"
  default     = "ami-0e72545e0a1a5c759"
}

# variable "peer_account_id" {
#   description = "Peer accounbt ID to create RDS"
# }
variable "RoleArn" {
  description = "ACCOUNT ROLE ARN FOR ALL OTHER RESOURCES"
}

variable "DBRoleArn" {
  description = "RDS ACCOUNT ROLE ARN"
}

##############################################################################################
variable "cm_app_instance_type" {
  description = "The EC2 instance type for CM-APP ECS Cluster"
}

variable "cm_utilities_instance_type" {
  description = "The EC2 instance type for CM-Utilities ECS Cluster"
}
variable "iam_instance_profile" {
  description = "IAM Instance Profile for Launch Template for ECS"
}

variable "cm_app_container_port" {
  type = number
}
# variable "cm_app_new_host_port" {
#   type = number
# }

variable "cm_web_container_port" {
  type = number
}
# variable "cm_web_new_host_port" {
#   type = number
# }

variable "cm_fetcher_container_port" {
  type = number
}
# variable "cm_fetcher_new_host_port" {
#   type = number
# }

variable "cm_central_container_port" {
  type = number
}
# variable "cm_central_new_host_port" {
#   type = number
# }

variable "cm_onboard_container_port" {
  type = number
}
# variable "cm_onboard_new_host_port" {
#   type = number
# }

variable "cm_report_container_port" {
  type = number
}
# variable "cm_report_new_host_port" {
#   type = number
# }

variable "cm_ecs_volume_size" {
  description = "EBS Volume Size for ECS Cluster Instance"
}

variable "cm_app_desired_capacity" {
  description = "Desired number of ECS instances in the cluster."
}

variable "cm_app_max_size" {
  description = "Maximum number of ECS instances in the cluster."
}

variable "cm_app_min_size" {
  description = "Minimum number of ECS instances in the cluster."
}

variable "cm_utilities_desired_capacity" {
  description = "Desired number of ECS instances in the cluster."
}

variable "cm_utilities_max_size" {
  description = "Maximum number of ECS instances in the cluster."
}

variable "cm_utilities_min_size" {
  description = "Minimum number of ECS instances in the cluster."
}

variable "cm_app_ecs_image" {
  description = "Docker Image for CM-App ECS Cluster"
}

variable "cm_web_ecs_image" {
  description = "Docker Image for CM-web"
}

variable "fetcher_ecs_image" {
  description = "Docker Image for fetcher"
}

variable "central_ecs_image" {
  description = "Docker Image for central"
}

variable "onboard_ecs_image" {
  description = "Docker Image for onboard"
}

variable "report_ecs_image" {
  description = "Docker Image for report"
}

#################################################################

variable "environment" {
  type        = string
  description = "Name of the env"
}

variable "region" {
  description = "The AWS region in which to launch resources."
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

################################################################
variable "elasticsearch_version" {
  description = "elasticsearch version"
}

variable "elasticsearch_instance_type" {
  description = "Instance Type for Elasticsearch"
}

variable "elasticsearch_ebs_enabled" {}
variable "elasticsearch_volume_size" {}
variable "advanced_security_options_enabled" {}
variable "elasticsearch_dedicated_master_enabled" {}
variable "elasticsearch_dedicated_master_count" {}
variable "elasticsearch_dedicated_master_type" {}

variable "elasticsearch_iam_role_arn" {
  description = "IAM Role for Elasticsearch"
}

variable "ssl_policy" {
  description = "ssl_policy name for alb listener"
}

variable "acm_certificate_arn" {
  description = "acm_certificate_arn for ssl_policy for alb listener"
}

variable "lb_listener_port" {
  description = "Listener Port No for Load Balancer"
}

variable "lb_listener_protocol" {
  description = "Listener Port No for Load Balancer"
}

variable "acm_domain_initial" {
  description = "Initial Value for the Domain Name for ACM Certificate"
}

##################################################################################

variable "rds_engine" {
  description = "name of the rds engine"
  type        = string
}

variable "rds_engine_version" {
  description = "RDS Engine version"
  type        = string
}

variable "rds_master_username" {
  description = "Master User Name for RDS"
  type        = string
}

variable "rds_master_password" {
  description = "Master Password for RDS"
  type        = string
}

variable "rds_instance_class" {
  description = "Database Instance Class"
}

variable "rds_instance_count" {
  description = "Instance Count for RDS"
}

variable "rds_backup_retention_period" {
  description = "Days to retain backups for RDS"
}

variable "azs" {
  description = "Availability Zones"
  type = list(string)
}

variable "rds_database_name" {
  description = "provide the name for the rds data base" 
}

############################################################################################

variable "redis_num_node_groups" {
  description = "Number of node groups (shards) for this Redis replication group"
}

variable "redis_replicas_per_node_group" {
  description = "Number of replica nodes in each node group"
}

variable "redis_encryption_at_rest_enabled" {
  description = "Whether to enable encryption at rest"
  type = bool
}

variable "redis_transit_encryption_enabled" {
  description = "Whether to enable encryption in transit"
  type = bool
}

variable "redis_auth_token" {
  description = "Password used to access a password protected server"
}

# variable "redis_auth_token_update_strategy" {
#   description = "Strategy to use when updating the auth_token"
# }

variable "target_group_protocol" {
  description = "Protocol for Target Group of ALB"
}

variable "elasticache_parameter_group_name" {
  description ="elasticache parameter group name"
}