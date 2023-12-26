# locals {
#     tags = {
#     "environment" = "${var.environment}",
#     "Region" = "${var.aws_region}",
#     "requestor" = "${var.requestor}",
#     "customer" = "${var.customer}",
#     "tenant" = "${var.tenant}",
#     "product" = "${var.product}",
#     "manager" = "${var.manager}",
#     "owner" = "${var.owner}",
#     "purpose" = "${var.purpose}"
#   }
# }

# resource "aws_mq_broker" "rabbit_mq" {
#   broker_name = "${var.product}-${var.environment}-rabbit-mq"

#   configuration {
#     id       = aws_mq_configuration.rabbit_mq.id
#     revision = aws_mq_configuration.rabbit_mq.latest_revision
#   }
#   engine_type        = "RabbitMQ"
#   engine_version     = var.engine_version #"3.11.20"
#   host_instance_type = var.host_instance_type #"mq.m5.large"
#   security_groups    = var.security_groups
#   subnet_ids         = var.subnet_ids
#   deployment_mode    = var.deployment_mode #"CLUSTER_MULTI_AZ"

#   user {
#     username = "cmrabbitadmin"
#     password = "cmrabbitadmin"
#   }

#   tags = merge(
#     local.tags, {"Name" = "${var.product}-${var.environment}-rabbit-mq"}
#   )
# }

# resource "aws_mq_configuration" "rabbit_mq" {
#   name           = "${var.product}-${var.environment}-rabbit-mq-config"
#   engine_type    = "RabbitMQ"
#   engine_version = var.engine_version #"3.11.20"

#   data = <<DATA
# # Default RabbitMQ delivery acknowledgement timeout is 30 minutes in milliseconds
# consumer_timeout = 1800000
# DATA

# tags = merge(
#     local.tags, {"Name" = "${var.product}-${var.environment}-rabbit-mq-config"}
#   )
# }


locals {
    tags = {
    "environment" = "${var.environment}",
    "Region" = "${var.aws_region}",
    "requestor" = "${var.requestor}",
    "customer" = "${var.customer}",
    "tenant" = "${var.tenant}",
    "product" = "${var.product}",
    "manager" = "${var.manager}",
    "owner" = "${var.owner}",
    "purpose" = "${var.purpose}"
  }
}


data "aws_ami" "lt_image" {
  count = var.ami_id != "" ? 0 : 1
  most_recent      = true
  name_regex       = "^Ondot AmazonLinux2 Golden Image-\\d{3}"
  owners           = ["self"]
  filter {
    name   = "name"
    values = ["Ondot AmazonLinux2 Golden Image-*"]
  }
}


resource "aws_instance" "rabbit-instance" {
  instance_type   = var.instance_type
  ami             = var.ami_id != "" ? var.ami_id : data.aws_ami.lt_image[0].id
  subnet_id       = var.subnet_id
  security_groups = var.security_groups
  key_name        = var.rabbit_key_name
  # key_name        = aws_key_pair.rabbit_key.key_name
  
  # user_data = <<-EOF
  #               #!/bin/bash
  #               sudo apt-get update -y
  #               sudo apt-get install -y rabbitmq-server
  #               sudo service rabbitmq-server start
  #               # Enable RabbitMQ management plugin (optional)
  #               sudo rabbitmq-plugins enable rabbitmq_management
  #               # Set up RabbitMQ users, vhosts, and permissions (customize as needed)
  #               sudo rabbitmqctl add_user rabbit rabbit
  #               sudo rabbitmqctl set_user_tags rabbit administrator
  #               sudo rabbitmqctl add_vhost rabbit
  #               sudo rabbitmqctl set_permissions -p rabbit rabbit ".*" ".*" ".*"
  #               # Restart RabbitMQ for changes to take effect
  #               sudo service rabbitmq-server restart
  #             EOF

tags = merge(
    local.tags, {"Name" = "${var.product}-${var.environment}-${var.resource_name}-Server"}
  )
}


# resource "tls_private_key" "rabbit_key" {
#   algorithm = "RSA"
#   rsa_bits  = 4096
# }

# resource "aws_key_pair" "rabbit_key" {
#   key_name   = "${var.product}-${var.environment}-${var.resource_name}-key"
#   public_key = tls_private_key.rabbit_key.public_key_openssh

#   tags = merge(
#     local.tags, {"Name" = "${var.product}-${var.environment}-${var.resource_name}-key"}
#   )
# }