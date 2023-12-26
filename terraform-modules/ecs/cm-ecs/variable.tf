# variable "cluster_name" {
#   description = "Name of the ECS cluster."
# }

variable "vpc_id" {
  description = "ID of the VPC where the ECS cluster will be created."
}

variable "subnets" {
  description = "subnet IDs to launch ECS tasks."
}

variable "subnet" {
  description = "List of subnet IDs to launch ECS tasks."
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

variable "security_group_id" {
  description = "ECS security group id"
}


variable "httplistnerarn" {
  description = "ALB listner ARN"
}

variable "cm_app_instance_type" {
  description = "The EC2 instance type"
  type        = string
}

variable "cm_utilities_instance_type" {
  description = "The EC2 instance type"
  type        = string
}

variable "ami_id" {
  description = "The AMI ID to use for the ECS EC2 instance."
}

variable "RoleArn" {
  description = "ACCOUNT ROLE ARN FOR ALL OTHER RESOURCES"
}
variable "DBRoleArn" {
  description = "RDS ACCOUNT ROLE ARN"
}

variable "cm_app_container_port" {}
# variable "cm_app_new_host_port" {}

variable "cm_web_container_port" {}
# variable "cm_web_new_host_port" {}

variable "cm_fetcher_container_port" {}
# variable "cm_fetcher_new_host_port" {}

variable "cm_central_container_port" {}
# variable "cm_central_new_host_port" {}

variable "cm_onboard_container_port" {}
# variable "cm_onboard_new_host_port" {}

variable "cm_report_container_port" {}
# variable "cm_report_new_host_port" {}

variable "ecs_volume_size" {
  description = "EBS Volume Size for ECS Cluster Instance"
}

variable "iam_instance_profile" {
  description = "IAM Instance Profile for Launch Template"
}

variable "lb_listener_port" {
  description = "Listener Port No for Load Balancer"
}

variable "lb_listener_protocol" {
  description = "Listener Port No for Load Balancer"
}

variable "target_group_protocol" {
  description = "Protocol for Target Group"
}

variable "app_alb_listener_2_arn" {
  description = "Listener-2 ARN of APP ALB"
}

variable "ecs_lt_key_name" {
  description = "Keypair Name for Launch Template for ASG"
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