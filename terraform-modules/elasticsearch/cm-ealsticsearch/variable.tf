variable "subnet_id" {
  description = "The ID of the subnet."
  type        = string
}

variable "security_group_id" {
  description = "The security group for ElasticSearch."
  type        = list(any)
}
variable "RoleArn" {
  description = "ACCOUNT ROLE ARN FOR ALL OTHER RESOURCES"
}
variable "DBRoleArn" {
  description = "RDS ACCOUNT ROLE ARN"
}

variable "elasticsearch_version" {
  description = "elasticsearch version"
}

variable "elasticsearch_instance_type" {
  description = "Instance Type for Elasticsearch"
}

variable "elasticsearch_ebs_enabled" {}
variable "elasticsearch_volume_size" {}
variable "advanced_security_options_enabled" {}
variable "dedicated_master_enabled" {}
variable "dedicated_master_count" {}
variable "dedicated_master_type" {}
variable "role_arn" {
  description = "IAM Role for Elasticsearch"
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