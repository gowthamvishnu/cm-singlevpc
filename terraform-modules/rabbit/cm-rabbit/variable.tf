# variable "host_instance_type" {
#   description = "The instance type for Rabbit MQ"
#   type        = string
# }
# variable "engine_version" {
#   description = "Engine Version for Rabbit MQ"
# }
# variable "subnet_ids" {
#   description = "The ID of the subnet where the EC2 instance should be launched."
#   type        = list(string)
# }
# variable "deployment_mode" {
#   description = "Deployment mode of the Rabbit MQ"
# }

# variable "security_groups" {
#   description = "The security group for EC2."
#   type        = list(string)
# }
# variable "RoleArn" {
#   description = "ACCOUNT ROLE ARN FOR ALL OTHER RESOURCES"
# }
# variable "DBRoleArn" {
#   description = "RDS ACCOUNT ROLE ARN"
# }
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
  description = "Name of the Resource for Rabbit MQ"
}

variable "rabbit_key_name" {
  description = "Keypair Name for Rabbit MQ Server"
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