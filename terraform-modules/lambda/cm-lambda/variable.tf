variable "subnet_ids" {
  description = "A list of subnet IDs for the Lambda function's VPC configuration."
  type        = list(string)
}

variable "security_group_ids" {
  description = "A list of security group IDs for the Lambda function's VPC configuration."
  type        = list(string)
}
variable "RoleArn" {
  description = "ACCOUNT ROLE ARN FOR ALL OTHER RESOURCES"
}
variable "DBRoleArn" {
  description = "RDS ACCOUNT ROLE ARN"
}

#--------------------------------------------------------------------------

variable "resource_name" {
  type        = string
  description = "Name of the Resource"
}

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