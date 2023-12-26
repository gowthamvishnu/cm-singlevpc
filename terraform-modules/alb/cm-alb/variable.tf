# DMZ ALB-------------------------------------------------
# variable "dmz_alb_subnets" {
#   description = "DMZ VPC ALB SUBNETS"
#   type        = list(string)
# }

# variable "security_group" {
#   description = "DMZ VPC ALB Security Groups"
#   type        = list(string)
# }
#variable "private_ips" {
#  type    = list(string)
#  default = ["10.0.1.10", "10.0.1.11", "10.0.1.12"] # Replace with your actual private IP addresses
#}

variable "alb_app_vpc" {
  description = " ID"
}
# variable "dmz_alb_vpc" {
#   description = " ID"
# }
# # variable "region" {
#   description = "The AWS region in which to launch the EC2 instance."
# }
#variable "app_nlb_target_id" {
#  description = "ALB APP VPC ID"
#}

#---------------------------------------------------------------
#APP ALB

variable "app_alb_subnets" {
  description = "APP VPC ALB SUBNETS"
  type        = list(string)
}

variable "app_security_group" {
  description = "APP VPC ALB Security Groups"
  type        = list(string)
}

#variable "app_alb_target_id" {
#  description = "app alb target id"
#}

#variable "nlb_null_id" {
#  description = "dummy value"
#}
variable "nlb_file_path" {
  description = "nlb file path"
  default     = "/home/ubuntu/Terraform/cm-migration-automation-modularized/nlb.txt" # Update with the actual path to nlb.txt
}

#-------------------------------------------------------------------------------------------------------

# DMZ NLB VARIABLES---------------------

# variable "dmz_nlb_subnets" {
#   description = "DMZ VPC NLB SUBNETS"
#   type        = list(string)
# }

# variable "nlb_security_group" {
#   description = "DMZ VPC NLB Security Groups"
#   type        = list(string)
# }

# variable "nlb_dmz_vpc_id" {
#   description = "NLB DMZ VPC ID"
# }

# variable "target_id" {
#   description = "add to dmz nlb, target id of dmz alb"
# }

#- -----------------------------------------------------------

# variable "app_nlb_subnets" {
#   description = "APP VPC NLB SUBNETS"
#   type        = list(string)
# }

# variable "app_nlb_security_group" {
#   description = "APP VPC NLB Security Groups"
#   type        = list(string)
# }

# variable "app_nlb_vpc_id" {
#   description = "NLB DMZ VPC ID"
# }

# variable "app_target_id" {
#   description = "add to app nlb, target id of app alb"
# }

#variable "nlb_file_path" {
#  description = "nlb file path"
#  default     = "/home/ubuntu/Terraform/cm-migration-automation-modularized/nlb.txt" # Update with the actual path to nlb.txt
#}
variable "RoleArn" {
  description = "ACCOUNT ROLE ARN FOR ALL OTHER RESOURCES"
}
variable "DBRoleArn" {
  description = "RDS ACCOUNT ROLE ARN"
}

variable "lb_listener_port" {
  description = "Listener Port No for Load Balancer"
}

variable "lb_listener_protocol" {
  description = "Listener Port No for Load Balancer"
}

variable "ssl_policy" {
  description = "ssl_policy name for alb listener"
}

variable "certificate_arn" {
  description = "certificate_arn for ssl_policy for alb listener"
}

variable "target_group_protocol" {
  description = "Protocol for Target Group"
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