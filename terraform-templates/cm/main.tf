data "aws_caller_identity" "current" {}

data "aws_availability_zones" "available" {}

locals {
  azs = slice(data.aws_availability_zones.available.names, 0, 2)
}


module "network" {
  source      = "../../terraform-modules/network/cm-network"
  aws_region  = var.region
  environment = var.environment
  # vpc_peering_connection_id     = module.vpc_peering.peering_connection_id_app_to_rds
  # dmz_vpc_peering_connection_id = module.vpc_peering.peering_connection_id
  cm_vpc_cidr_block           = var.cm_vpc_cidr_block
  cm_vpc_id                   = var.cm_vpc_id
  create_nat_gw               = var.create_nat_gw
  create_subnets              = var.create_subnets
  existing_subnet_ids         = var.existing_subnet_ids
  private_subnets_for_dbgroup = length(var.existing_subnet_ids) > 0 ? var.existing_subnet_ids : module.network.private_subnets
  RoleArn                     = var.RoleArn
  DBRoleArn                   = var.DBRoleArn
  enable_dns_support          = var.enable_dns_support
  enable_dns_hostnames        = var.enable_dns_hostnames
  instance_tenancy            = var.instance_tenancy
  azs                         = local.azs
  requestor                   = var.requestor
  customer                    = var.customer
  tenant                      = var.tenant
  product                     = var.product
  manager                     = var.manager
  owner                       = var.owner
  purpose                     = var.purpose
}

# module "vpc_peering" {
#   source = "../../terraform-modules/vpc-peering/cm-vpc-peering"

#   aws_region                    = var.region
#   environment                   = var.environment
#   #To connect DMZ ALB VPC to APP NLB VPC 
#   peer_vpc_id = module.network.dmz_vpc_id
#   vpc_id      = module.network.app_vpc_id

#   #To connect APP VPC TO RDS VPC
#   peer_account_id = var.peer_account_id #"480459741140"
#   rds_peer_vpc_id = module.network.rds_vpc_id
#   app_vpc_id      = module.network.app_vpc_id
#   RoleArn         = var.RoleArn
#   DBRoleArn       = var.DBRoleArn
# }

module "security_groups" {
  source        = "../../terraform-modules/sg/cm-sg"
  aws_region    = var.region
  environment   = var.environment
  resource_name = "SG"
  vpc_id        = module.network.vpc_id
  RoleArn       = var.RoleArn
  DBRoleArn     = var.DBRoleArn
  requestor     = var.requestor
  customer      = var.customer
  tenant        = var.tenant
  product       = var.product
  manager       = var.manager
  owner         = var.owner
  purpose       = var.purpose
}

module "alb" {
  source                = "../../terraform-modules/alb/cm-alb"
  aws_region            = var.region
  environment           = var.environment
  requestor             = var.requestor
  customer              = var.customer
  tenant                = var.tenant
  product               = var.product
  manager               = var.manager
  owner                 = var.owner
  purpose               = var.purpose
  resource_name         = "ALB"
  target_group_protocol = var.target_group_protocol
  #app_alb_subnets      = length(var.existing_subnet_ids) > 0 ? var.existing_subnet_ids : module.network.private_subnets 
  #app_security_group       = [module.security_groups.app_alb_security_group_id]
  #alb_app_vpc          = module.network.vpc_id
  ssl_policy           = var.ssl_policy
  certificate_arn      = var.acm_certificate_arn != "" ? var.acm_certificate_arn : "${aws_acm_certificate.acm_certificate[0].arn}"
  lb_listener_port     = var.lb_listener_port
  lb_listener_protocol = var.lb_listener_protocol
  #app_nlb_target_id = module.nlb.app_nlb_arn    #####################

  #---- APP ALB VARIABLES
  app_security_group = [module.security_groups.app_alb_security_group_id]
  app_alb_subnets    = length(var.existing_subnet_ids) > 0 ? var.existing_subnet_ids : module.network.private_subnets
  alb_app_vpc        = module.network.vpc_id
  #app_alb_target_id  = module.ecs.ecs_cluster_id
  #nlb_null_id        = module.nlb.nlb_null_id

  #-----------------------------------------------------------
  #dmz_nlb_subnets    = length(var.existing_subnet_ids) > 0 ? var.existing_subnet_ids : module.network.private_subnets 
  #nlb_security_group = [module.security_groups.dmz_nlb_security_group_id]
  #nlb_dmz_vpc_id     = module.network.vpc_id
  #target_id          = module.alb.dmz_alb_arn

  #app_nlb_subnets        = length(var.existing_subnet_ids) > 0 ? var.existing_subnet_ids : module.network.private_subnets  
  #app_nlb_security_group = [module.security_groups.app_nlb_security_group_id]
  #app_nlb_vpc_id         = module.network.vpc_id
  #app_target_id          = module.alb.app_alb_arn
  RoleArn   = var.RoleArn
  DBRoleArn = var.DBRoleArn
}



# module "waf" {
#   source = "../../terraform-modules/waf/cm-waf"
#   #create_waf = var.create_waf
#   #existing_waf_name = var.existing_waf_name
#   aws_region    = var.region
#   environment   = var.environment
#   resource_name = "WAF"
#   resource_arn  = module.alb.app_alb_arn
#   RoleArn       = var.RoleArn
#   DBRoleArn     = var.DBRoleArn
#   requestor     = var.requestor
#   customer      = var.customer
#   tenant        = var.tenant
#   product       = var.product
#   manager       = var.manager
#   owner         = var.owner
#   purpose       = var.purpose

# }

# module "nat" {
#   source        = "../../terraform-modules/nat/cm-nat"
#   aws_region    = var.region
#   environment   = var.environment
#   resource_name = "NGW"
#   subnet_id     = length(var.existing_subnet_ids) > 0 ? var.existing_subnet_ids[0] : module.network.private_subnets[0]
#   RoleArn       = var.RoleArn
#   DBRoleArn     = var.DBRoleArn
#   requestor     = var.requestor
#   customer      = var.customer
#   tenant        = var.tenant
#   product       = var.product
#   manager       = var.manager
#   owner         = var.owner
#   purpose       = var.purpose
# }

module "efs" {
  source             = "../../terraform-modules/efs/cm-efs"
  aws_region         = var.region
  environment        = var.environment
  resource_name      = "EFS"
  security_group_ids = [module.security_groups.app_efs_security_group_id]
  subnet_id         = length(var.existing_subnet_ids) > 0 ? var.existing_subnet_ids[0] : module.network.private_subnets[0] #module.network.private_subnets 
  RoleArn            = var.RoleArn
  DBRoleArn          = var.DBRoleArn
  requestor          = var.requestor
  customer           = var.customer
  tenant             = var.tenant
  product            = var.product
  manager            = var.manager
  owner              = var.owner
  purpose            = var.purpose
}

module "lambda" {
  source             = "../../terraform-modules/lambda/cm-lambda"
  aws_region         = var.region
  environment        = var.environment
  resource_name      = "lambda"
  subnet_ids         = length(var.existing_subnet_ids) > 0 ? var.existing_subnet_ids : module.network.private_subnets #module.network.private_subnets
  security_group_ids = [module.security_groups.app_lambda_security_group_id]
  RoleArn            = var.RoleArn
  DBRoleArn          = var.DBRoleArn
  requestor          = var.requestor
  customer           = var.customer
  tenant             = var.tenant
  product            = var.product
  manager            = var.manager
  owner              = var.owner
  purpose            = var.purpose
}

# module "bastion" {
#   source                = "../../terraform-modules/bastion/cm-bastion"
#   aws_region            = var.region
#   environment           = var.environment
#   resource_name         = "Bastion"
#   ami_id                = var.bastion_ami_id
#   bastion_instance_type = var.bastion_instance_type
#   subnet_id             = length(var.existing_subnet_ids) > 0 ? var.existing_subnet_ids[0] : module.network.private_subnets[0] #element(module.network.private_subnets, 0)
#   security_groups       = [module.security_groups.app_bastion_security_group_id]
#   RoleArn               = var.RoleArn
#   DBRoleArn             = var.DBRoleArn
#   requestor             = var.requestor
#   customer              = var.customer
#   tenant                = var.tenant
#   product               = var.product
#   manager               = var.manager
#   owner                 = var.owner
#   purpose               = var.purpose
# }

module "rds" {
  source                  = "../../terraform-modules/rds/cm-rds"
  azs                     = var.azs
  aws_region              = var.region
  environment             = var.environment
  rds_engine              = var.rds_engine
  rds_engine_version      = var.rds_engine_version
  rds_instance_class      = var.rds_instance_class
  rds_instance_count      = var.rds_instance_count
  rds_master_username     = var.rds_master_username
  rds_master_password     = var.rds_master_password
  rds_database_name       = var.rds_database_name
  backup_retention_period = var.rds_backup_retention_period
  db_subnet_group_name    = module.network.rds_subnet_group_name
  vpc_security_group_ids  = module.security_groups.rds_security_group_id
  RoleArn                 = var.RoleArn
  DBRoleArn               = var.DBRoleArn
  requestor               = var.requestor
  customer                = var.customer
  tenant                  = var.tenant
  product                 = var.product
  manager                 = var.manager
  owner                   = var.owner
  purpose                 = var.purpose
}

module "sns" {
  source      = "../../terraform-modules/sns/cm-sns"
  aws_region  = var.region
  environment = var.environment
  RoleArn     = var.RoleArn
  DBRoleArn   = var.DBRoleArn
  requestor   = var.requestor
  customer    = var.customer
  tenant      = var.tenant
  product     = var.product
  manager     = var.manager
  owner       = var.owner
  purpose     = var.purpose
}

module "sqs" {
  source      = "../../terraform-modules/sqs/cm-sqs"
  aws_region  = var.region
  environment = var.environment
  RoleArn     = var.RoleArn
  DBRoleArn   = var.DBRoleArn
  requestor   = var.requestor
  customer    = var.customer
  tenant      = var.tenant
  product     = var.product
  manager     = var.manager
  owner       = var.owner
  purpose     = var.purpose
}

module "api_gateway" {
  source          = "../../terraform-modules/api-gateway/cm-api-gateway"
  aws_region      = var.region
  environment     = var.environment
  api_description = "My API Gateway"
  RoleArn         = var.RoleArn
  DBRoleArn       = var.DBRoleArn
  requestor       = var.requestor
  customer        = var.customer
  tenant          = var.tenant
  product         = var.product
  manager         = var.manager
  owner           = var.owner
  purpose         = var.purpose
}

module "redis" {
  source                           = "../../terraform-modules/elasticache/cm-redis"
  elasticache_cluster_type         = "redis"
  elasticache_engine               = "redis"
  elasticache_port                 = "6379"
  num_node_groups                  = var.redis_num_node_groups
  replicas_per_node_group          = var.redis_replicas_per_node_group
  at_rest_encryption_enabled       = var.redis_encryption_at_rest_enabled
  transit_encryption_enabled       = var.redis_transit_encryption_enabled
  auth_token                       = var.redis_auth_token
  #auth_token_update_strategy       = var.redis_auth_token_update_strategy
  aws_region                       = var.region
  elasticache_node_type            = var.redis_node_type
  elasticache_parameter_group_name = var.elasticache_parameter_group_name
  elasticache_engine_version       = var.redis_engine_version                                                                             #"5.0.6"
  elasticache_subnet_ids           = length(var.existing_subnet_ids) > 0 ? var.existing_subnet_ids : module.network.private_subnets #element(module.network.private_subnets, 0)
  elasticache_security_group_ids   = [module.security_groups.app_redis_security_group_id]
  RoleArn                          = var.RoleArn
  DBRoleArn                        = var.DBRoleArn
  environment                      = var.environment
  requestor                        = var.requestor
  customer                         = var.customer
  tenant                           = var.tenant
  product                          = var.product
  manager                          = var.manager
  owner                            = var.owner
  purpose                          = var.purpose
}

module "logstash" {
  source          = "../../terraform-modules/logstash/cm-logstash" #check in logs if logstash is installed
  aws_region      = var.region
  environment     = var.environment
  resource_name   = "Logstash"
  instance_type   = var.logstash_instance_type
  ami_id          = var.logstash_ami_id
  subnet_id       = length(var.existing_subnet_ids) > 0 ? var.existing_subnet_ids[0] : module.network.private_subnets[0] ##element(module.network.private_subnets, 0)
  security_groups = [module.security_groups.app_logstash_security_group_id]
  logstash_key_name = module.keypair_ec2.ec2_key_name
  RoleArn         = var.RoleArn
  DBRoleArn       = var.DBRoleArn
  requestor       = var.requestor
  customer        = var.customer
  tenant          = var.tenant
  product         = var.product
  manager         = var.manager
  owner           = var.owner
  purpose         = var.purpose

}

module "rabbit" {
  source        = "../../terraform-modules/rabbit/cm-rabbit" #check in logs if logstash is installed
  aws_region    = var.region
  environment   = var.environment
  instance_type = var.rabbit_instance_type
  ami_id        = var.rabbit_ami_id
  resource_name = "rabbit"
  #host_instance_type = var.rabbit_instance_type  #"mq.m5.large"
  subnet_id       = length(var.existing_subnet_ids) > 0 ? var.existing_subnet_ids[0] : module.network.private_subnets[0] # module.network.private_subnets
  security_groups = [module.security_groups.app_rabbit_security_group_id]
  rabbit_key_name = module.keypair_ec2.ec2_key_name
  RoleArn         = var.RoleArn
  DBRoleArn       = var.DBRoleArn
  requestor       = var.requestor
  customer        = var.customer
  tenant          = var.tenant
  product         = var.product
  manager         = var.manager
  owner           = var.owner
  purpose         = var.purpose
}

module "elasticsearch" {
  source            = "../../terraform-modules/elasticsearch/cm-ealsticsearch"
  subnet_id         = length(var.existing_subnet_ids) > 0 ? var.existing_subnet_ids[0] : module.network.private_subnets[0] #module.network.private_subnets[0]
  security_group_id = [module.security_groups.app_elastic_security_group_id]
  aws_region        = var.region
  environment       = var.environment
  RoleArn           = var.RoleArn
  DBRoleArn         = var.DBRoleArn
  requestor         = var.requestor
  customer          = var.customer
  tenant            = var.tenant
  product           = var.product
  manager           = var.manager
  owner             = var.owner
  purpose           = var.purpose

  elasticsearch_version             = var.elasticsearch_version
  elasticsearch_instance_type       = var.elasticsearch_instance_type
  elasticsearch_ebs_enabled         = var.elasticsearch_ebs_enabled
  elasticsearch_volume_size         = var.elasticsearch_volume_size
  advanced_security_options_enabled = var.advanced_security_options_enabled
  dedicated_master_enabled          = var.elasticsearch_dedicated_master_enabled
  dedicated_master_count            = var.elasticsearch_dedicated_master_count
  dedicated_master_type             = var.elasticsearch_dedicated_master_type
  role_arn                          = var.elasticsearch_iam_role_arn

}

module "ecs" {
  source                        = "../../terraform-modules/ecs/cm-ecs"
  ami_id                        = var.ecs_lt_ami_id
  cm_app_instance_type          = var.cm_app_instance_type
  cm_utilities_instance_type    = var.cm_utilities_instance_type
  vpc_id                        = module.network.vpc_id
  subnets                       = length(var.existing_subnet_ids) > 0 ? var.existing_subnet_ids[0] : module.network.private_subnets[0] #element(module.network.private_subnets, 0) # Use all private subnets 
  subnet                        = length(var.existing_subnet_ids) > 0 ? var.existing_subnet_ids : module.network.private_subnets       #module.network.private_subnets
  security_group_id             = [module.security_groups.app_ecs_security_group_id]
  target_group_protocol         = "HTTP"
  app_alb_listener_2_arn        = module.alb.app_alb_listener_2_arn
  cm_app_desired_capacity       = var.cm_app_desired_capacity
  cm_app_max_size               = var.cm_app_max_size
  cm_app_min_size               = var.cm_app_min_size
  cm_utilities_desired_capacity = var.cm_utilities_desired_capacity
  cm_utilities_max_size         = var.cm_utilities_max_size
  cm_utilities_min_size         = var.cm_utilities_min_size

  cm_app_ecs_image     = var.cm_app_ecs_image
  cm_web_ecs_image     = var.cm_web_ecs_image
  fetcher_ecs_image    = var.fetcher_ecs_image
  central_ecs_image    = var.central_ecs_image
  onboard_ecs_image    = var.onboard_ecs_image
  report_ecs_image     = var.report_ecs_image
  iam_instance_profile = var.iam_instance_profile
  ecs_lt_key_name      = module.keypair_ec2.ec2_key_name

  httplistnerarn        = module.alb.httplistnerarn
  RoleArn               = var.RoleArn
  DBRoleArn             = var.DBRoleArn
  environment           = var.environment
  aws_region            = var.region
  requestor             = var.requestor
  customer              = var.customer
  tenant                = var.tenant
  product               = var.product
  manager               = var.manager
  owner                 = var.owner
  purpose               = var.purpose
  cm_app_container_port = var.cm_app_container_port
  #cm_app_new_host_port      = var.cm_app_new_host_port
  cm_web_container_port = var.cm_web_container_port
  #cm_web_new_host_port      = var.cm_web_new_host_port
  cm_fetcher_container_port = var.cm_fetcher_container_port
  #cm_fetcher_new_host_port  = var.cm_fetcher_new_host_port
  cm_onboard_container_port = var.cm_onboard_container_port
  #cm_onboard_new_host_port  = var.cm_onboard_new_host_port
  cm_central_container_port = var.cm_central_container_port
  #cm_central_new_host_port  = var.cm_central_new_host_port
  cm_report_container_port = var.cm_report_container_port
  #cm_report_new_host_port   = var.cm_report_new_host_port
  ecs_volume_size = var.cm_ecs_volume_size

  lb_listener_port     = var.lb_listener_port
  lb_listener_protocol = var.lb_listener_protocol

}

module "secret" {
  source                  = "../../terraform-modules/secret/cm-secret"
  RoleArn                 = var.RoleArn
  DBRoleArn               = var.DBRoleArn
  environment             = var.environment
  aws_region              = var.region
  requestor               = var.requestor
  customer                = var.customer
  tenant                  = var.tenant
  product                 = var.product
  manager                 = var.manager
  owner                   = var.owner
  purpose                 = var.purpose
  recovery_window_in_days = "0"
}

##################################################
# Resource for ACM Certificate
##################################################
resource "aws_acm_certificate" "acm_certificate" {
  count             = var.acm_certificate_arn != "" ? 0 : 1
  domain_name       = "${var.acm_domain_initial}.internal.ondotsystems.com"
  validation_method = "DNS"

  validation_option {
    domain_name       = "${var.acm_domain_initial}.internal.ondotsystems.com"
    validation_domain = "internal.ondotsystems.com"
  }
  lifecycle {
    create_before_destroy = true
  }

  tags = {
    "Name"        = "${var.customer}-${var.environment}-${var.product}-acm-certificate",
    "environment" = "${var.environment}",
    "Region"      = "${var.region}",
    "requestor"   = "${var.requestor}",
    "customer"    = "${var.customer}",
    "tenant"      = "${var.tenant}",
    "product"     = "${var.product}",
    "manager"     = "${var.manager}",
    "owner"       = "${var.owner}",
    "purpose"     = "${var.purpose}"
  }
}


##################################################
# Resource for EC2 Key-Pair
##################################################
module "keypair_ec2" {
  source                  = "../../terraform-modules/keypair-ec2"
  RoleArn                 = var.RoleArn
  DBRoleArn               = var.DBRoleArn
  environment             = var.environment
  aws_region              = var.region
  requestor               = var.requestor
  customer                = var.customer
  tenant                  = var.tenant
  product                 = var.product
  manager                 = var.manager
  owner                   = var.owner
  purpose                 = var.purpose
}
