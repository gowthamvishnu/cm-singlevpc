
variable "RoleArn" {
  description = "ACCOUNT ROLE ARN FOR ALL OTHER RESOURCES"
}
variable "DBRoleArn" {
  description = "RDS ACCOUNT ROLE ARN"
}

variable "cm_vpc_id" {
  #type        = string
  description = "VPC ID of the Existing VPC"
}

variable "cm_vpc_cidr_block" {
  description = "VPC CIDR range"
  type    = string
}

variable "create_subnets" {
  description  = "create subnets true or false"
}


variable "existing_subnet_ids" {
description = "subnet IDs of the Existing VPC"
}

variable "private_subnets_for_dbgroup" {
description = "subnet IDs of the db subnet group"
}


variable "enable_dns_support" {
  description = "A boolean flag to enable/disable DNS support in the VPC. Defaults to true."
  type    = bool
}

variable "enable_dns_hostnames" {
  description = "A boolean flag to enable/disable DNS hostnames in the VPC"
  type    = bool
}

variable "instance_tenancy" {
  description = "Tenancy of instances spin up within VPC"
  type    = string
  default = "default"
}

# variable "private_subnet_count" {
#   description = "Private Subnet Count for the VPC"
# }

variable "azs" {
  description = "A list of availability zones names or ids in the region"
  type        = list(string)
}

variable "create_nat_gw" {
  description = "Create NAT Gateway or not (True/False)"
}



##########################################################################

variable "environment" {
  description = "The AWS environment"
}

variable "aws_region" {
  description = "The AWS region to create things in."
}

variable "requestor" {
  description = "The AWS region to create things in."
  }
variable "customer" {
  description = "The AWS region to create things in."
  
}

variable "tenant" {
  description = "The AWS region to create things in."
  
}

variable "product" {
  description = "The AWS region to create things in."
  
}

variable "manager" {
  description = "The AWS region to create things in."
 }

variable "owner" {
  description = "The AWS region to create things in."
 
}

variable "purpose" {
  description = "The AWS region to create things in."
  
}