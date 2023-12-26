variable "security_group_ids" {
  description = "List of subnet IDs where EFS will be mounted."
  type        = list(string)
}

variable "subnet_id" {
  description = "List of security group IDs for EFS access."
  type        = string
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