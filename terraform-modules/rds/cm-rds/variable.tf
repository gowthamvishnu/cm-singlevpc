# variable "db_subnet_group_name" {
#   description = "Name of the RDS DB subnet group"
#   type        = string
# }
# variable "vpc_security_group_ids" {
#   description = "Name for the RDS SG"
#   type        = string
# }
# variable "RoleArn" {
#   description = "ACCOUNT ROLE ARN FOR ALL OTHER RESOURCES"
# }
# variable "DBRoleArn" {
#   description = "RDS ACCOUNT ROLE ARN"
# }

variable "db_subnet_group_name" {
  description = "Name of the RDS DB subnet group"
  type        = string
}
variable "vpc_security_group_ids" {
  description = "Name for the RDS SG"
  type        = string
}
variable "RoleArn" {
  description = "ACCOUNT ROLE ARN FOR ALL OTHER RESOURCES"
}
variable "DBRoleArn" {
  description = "RDS ACCOUNT ROLE ARN"
}

variable "azs" {
  description = "Availability Zones"
  type = list(string)
}

variable "rds_engine" {
  description = "Name of the database engine to be used for this DB cluster"
}

variable "rds_engine_version" {
  description = "Database engine version"
}

variable "rds_instance_class" {
  description = "Database Instance Class"
}

variable "rds_master_username" {
  description = "Master User Name for RDS"
  type        = string
}

variable "rds_master_password" {
  description = "Master Password for RDS"
  type        = string
}

variable "rds_instance_count" {
  description = "Instance count for RDS"
}

variable "backup_retention_period" {
  description = "Days to retain backups for"
}

variable "rds_database_name" {
  description = "provide the name for the rds data base" 
}

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