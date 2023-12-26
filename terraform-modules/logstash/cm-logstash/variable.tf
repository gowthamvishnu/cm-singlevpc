variable "instance_type" {
  description = "The EC2 instance type"
  type        = string
}
variable "ami_id" {
  description = "The AMI ID to use for the EC2 instance."
}
variable "subnet_id" {
  description = "The ID of the subnet where the EC2 instance should be launched."
  type        = string
}

variable "security_groups" {
  description = "The security group for EC2."
  type        = list(string)
}
variable "RoleArn" {
  description = "ACCOUNT ROLE ARN FOR ALL OTHER RESOURCES"
}
variable "DBRoleArn" {
  description = "RDS ACCOUNT ROLE ARN"
}
variable "resource_name" {
  description = "Resource Name for Logstash"
}

variable "logstash_key_name" {
  description = "Keypair Name for Logstash"
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
