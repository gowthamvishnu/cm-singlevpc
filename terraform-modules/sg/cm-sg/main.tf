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

# DMZ VPC Security Groups-------------------------------------------
# Create a security group for the Network Load Balancer (NLB)
# resource "aws_security_group" "dmz_nlb_security_group" {
#   #  name        = "DMZ-NLBSecurityGroup"
#   description = "Security group for Network Load Balancer"
#   vpc_id      = var.vpc_id
#   # Define ingress rules as needed for your NLB
#   # Example: Allow incoming traffic on port 443 from anywhere
#   ingress {
#     from_port   = 443
#     to_port     = 443
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#   ingress {
#     from_port   = 8443
#     to_port     = 8443
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#   ingress {
#     from_port   = 80
#     to_port     = 80
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#   # Add more ingress rules if required
#         tags = merge(
#     local.tags, {"Name" = "${var.product}-${var.environment}-${var.resource_name}-DMZ-NLB Security Group"}
#   )
# }

# Create a security group for the Application Load Balancer (ALB)
# resource "aws_security_group" "dmz_alb_security_group" {
#   #  name        = "DMZ-ALBSecurityGroup"
#   description = "Security group for Application Load Balancer"
#   vpc_id      = var.vpc_id
#   # Define ingress rules as needed for your ALB
#   # Example: Allow incoming traffic on port 443 from the NLB's security group
#   ingress {
#     from_port       = 443
#     to_port         = 443
#     protocol        = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#     # security_groups = [aws_security_group.dmz_nlb_security_group.id]
#   }
#   ingress {
#     from_port       = 80
#     to_port         = 80
#     protocol        = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#     # security_groups = [aws_security_group.dmz_nlb_security_group.id]
#   }
#   ingress {
#     from_port       = 8443
#     to_port         = 8443
#     protocol        = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#     # security_groups = [aws_security_group.dmz_nlb_security_group.id]
#   }
#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#   # Add more ingress rules if required
#          tags = merge(
#     local.tags, {"Name" = "${var.product}-${var.environment}-${var.resource_name}-DMZ-ALB Security Group"}
#   )
# }

#-------------------------------------------------------------------
# APP VPC SECURITY GROUPS-------------------------------------------
#APP VPC NLB SG
# resource "aws_security_group" "app_nlb_security_group" {
#   #  name        = "APP-NLBSecurityGroup"
#   description = "Security group for Network Load Balancer"
#    vpc_id      = var.vpc_id
#   # Example: Allow incoming traffic on port 80 from the DMZ VPC - ALB's security group
#   ingress {
#     from_port       = 443
#     to_port         = 443
#     protocol        = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#     # security_groups = [aws_security_group.dmz_alb_security_group.id]
#   }
#   ingress {
#     from_port       = 80
#     to_port         = 80
#     protocol        = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#     # security_groups = [aws_security_group.dmz_alb_security_group.id]
#   }
#   ingress {
#     from_port       = 8443
#     to_port         = 8443
#     protocol        = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#     # security_groups = [aws_security_group.dmz_alb_security_group.id]
#   }
#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#   # Add more ingress rules if required
#   tags = merge(
#     local.tags, {"Name" = "${var.product}-${var.environment}-${var.resource_name}-APP-NLB Security Group"}
#   )
#   depends_on = [
#     aws_security_group.dmz_alb_security_group
#   ]
#}



#APP VPC ALB SG
resource "aws_security_group" "app_alb_security_group" {
  #  name        = "APP-ALBSecurityGroup"
  description = "Security group for Application Load Balancer"
  vpc_id      = var.vpc_id
  # Example: Allow incoming traffic on port 443 from the APP VPC - NLB's security group
  ingress {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    # security_groups = [aws_security_group.app_nlb_security_group.id]
  }
  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    # security_groups = [aws_security_group.app_nlb_security_group.id]
  }
  ingress {
    from_port       = 8443
    to_port         = 8443
    protocol        = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    # security_groups = [aws_security_group.app_nlb_security_group.id]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # Add more ingress rules if required
  tags = merge(
    local.tags, {"Name" = "${var.product}-${var.environment}-${var.resource_name}-APP-ALB Security Group"}
  )
}
# APP VPC NAT SG
resource "aws_security_group" "app_nat_security_group" {
  #  name        = "APP-NATSecurityGroup"
  description = "Security group for NAT Gateway in public subnet"
 vpc_id      = var.vpc_id
  # Example: Allow incoming traffic on port 443 from the APP VPC - ECS security group
  ingress {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    # security_groups = [aws_security_group.app_ecs_security_group.id]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # Add more ingress rules if required
  tags = merge(
    local.tags, {"Name" = "${var.product}-${var.environment}-${var.resource_name}-APP-NAT Security Group"}
  )
}
# APP VPC REDIS SG
resource "aws_security_group" "app_redis_security_group" {
  #  name        = "APP-REDISSecurityGroup"
  description = "Security group for Redis"
 vpc_id      = var.vpc_id
  # Example: Allow incoming traffic on port 443 from the APP VPC - ECS security group
  ingress {
    from_port       = 6379
    to_port         = 6379
    protocol        = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    # security_groups = [aws_security_group.app_ecs_security_group.id]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # Add more ingress rules if required
    tags = merge(
    local.tags, {"Name" = "${var.product}-${var.environment}-${var.resource_name}-APP-Redis Security Group"}
  )

}
# APP VPC RABBIT SG
resource "aws_security_group" "app_rabbit_security_group" {
  #  name        = "APP-RABBITSecurityGroup"
  description = "Security group for RabbitMQ"
 vpc_id      = var.vpc_id
  # Example: Allow incoming traffic on port 443 from the APP VPC - ECS security group
  ingress {
    from_port       = 5671
    to_port         = 5671
    protocol        = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    # security_groups = [aws_security_group.app_ecs_security_group.id]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # Add more ingress rules if required
      tags = merge(
    local.tags, {"Name" = "${var.product}-${var.environment}-${var.resource_name}-APP-Rabbit Security Group"}
  )
}

#APP VPC ECS SG
resource "aws_security_group" "app_ecs_security_group" {
  #  name        = "APP-ECSSecurityGroup"
  description = "Security group for Application ECS instances"
   vpc_id      = var.vpc_id
  # Inbound rules from app_alb_security_group
  ingress {
    from_port       = 8020
    to_port         = 8020
    protocol        = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    # security_groups = [aws_security_group.app_alb_security_group.id]
  }

  ingress {
    from_port       = 8040
    to_port         = 8040
    protocol        = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    # security_groups = [aws_security_group.app_alb_security_group.id]
  }

  ingress {
    from_port       = 9010
    to_port         = 9010
    protocol        = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    # security_groups = [aws_security_group.app_alb_security_group.id]
  }

  ingress {
    from_port       = 8050
    to_port         = 8050
    protocol        = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    # security_groups = [aws_security_group.app_alb_security_group.id]
  }

  ingress {
    from_port       = 8030
    to_port         = 8030
    protocol        = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    # security_groups = [aws_security_group.app_alb_security_group.id]
  }

  ingress {
    from_port       = 8010
    to_port         = 8010
    protocol        = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    # security_groups = [aws_security_group.app_alb_security_group.id]
  }

  ingress {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    # security_groups = [aws_security_group.app_alb_security_group.id]
  }
  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    # security_groups = [aws_security_group.app_alb_security_group.id]
  }
  # Outbound rules
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # Add more ingress rules if required
  tags = merge(
    local.tags, {"Name" = "${var.product}-${var.environment}-${var.resource_name}-APP-ECS Security Group"}
  )
}
# APP VPC KMS SG
resource "aws_security_group" "app_kms_security_group" {
  #  name        = "APP-KMSSecurityGroup"
  description = "Security group for KMS"
 vpc_id      = var.vpc_id
  # Example: Allow incoming traffic on port 443 from the APP VPC - ECS security group
  ingress {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    # security_groups = [aws_security_group.app_ecs_security_group.id] #[aws_security_group.app_ecs_security_group.id]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # Add more ingress rules if required
  tags = merge(
    local.tags, {"Name" = "${var.product}-${var.environment}-${var.resource_name}-APP-KMS Security Group"}
  )
}
# APP VPC LAMBDA SG
resource "aws_security_group" "app_lambda_security_group" {
  #  name        = "APP-LAMBDASecurityGroup"
  description = "Security group for Lambda service endpoint"
  vpc_id      = var.vpc_id # Specify the VPC ID where the Lambda service endpoint is located
  # Ingress rules for allowing incoming traffic to Lambda service
  ingress {
    from_port       = 443 # Assuming Lambda service communicates over HTTPS
    to_port         = 443
    protocol        = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    # security_groups = [aws_security_group.app_ecs_security_group.id]
  }
  # Add more ingress rules if needed
  # Outbound rules for Lambda service to communicate with other resources
  egress {
    from_port   = 0
    to_port     = 65535 # Allow outbound traffic to all ports
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # You may restrict this to specific IP ranges
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
   tags = merge(
    local.tags, {"Name" = "${var.product}-${var.environment}-${var.resource_name}-APP-LAMBDA Security Group"}
  )
}
# APP VPC LOGSTASH SG
resource "aws_security_group" "app_logstash_security_group" {
  #  name        = "APP-LOGSTASHSecurityGroup"
  description = "Security group for Logstash"
  vpc_id      = var.vpc_id
  # Example: Allow incoming traffic on port 443 from the APP VPC - ECS security group
  ingress {
    from_port       = 5000
    to_port         = 5000
    protocol        = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    # security_groups = [aws_security_group.app_ecs_security_group.id]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # Add more ingress rules if required
     tags = merge(
    local.tags, {"Name" = "${var.product}-${var.environment}-${var.resource_name}-APP-Logstash Security Group"}
  )
}
# APP VPC ElasticSearch SG
resource "aws_security_group" "app_elastic_security_group" {
  #  name        = "APP-ElasticSearchSecurityGroup"
  description = "Security group for ElasticSearch"
 vpc_id      = var.vpc_id
  # Example: Allow incoming traffic on port 443 from the APP VPC - ECS security group
  ingress {
    from_port       = 9200
    to_port         = 9200
    protocol        = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    # security_groups = [aws_security_group.app_logstash_security_group.id]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # Add more ingress rules if required
      tags = merge(
    local.tags, {"Name" = "${var.product}-${var.environment}-${var.resource_name}-APP-ElasticSearch Security Group"}
  )
}
# APP VPC EFS SG
resource "aws_security_group" "app_efs_security_group" {
  #  name        = "APP-EFSSecurityGroup"
  description = "Security group for EFS"
   vpc_id      = var.vpc_id
  # Inbound rules from app_ecs_security_group
  ingress {
    from_port       = 2049
    to_port         = 2049
    protocol        = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    # security_groups = [aws_security_group.app_ecs_security_group.id]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # Add more ingress rules if required
    tags = merge(
    local.tags, {"Name" = "${var.product}-${var.environment}-${var.resource_name}-APP-EFS Security Group"}
  )

}
# APP VPC Bastion SG
# resource "aws_security_group" "app_bastion_security_group" {
#   #  name        = "APP-BASTIONSecurityGroup"
#   description = "Security group for bastion"
#    vpc_id      = var.vpc_id
#   # Example: Allow incoming traffic on port 443.
#   ingress {
#     from_port   = 80
#     to_port     = 80
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#   # Add more ingress rules if required
#       tags = merge(
#     local.tags, {"Name" = "${var.product}-${var.environment}-${var.resource_name}-APP-Bastion Security Group"}
#   )
# }

#-------------------------------------------------------------------
# RDS VPC SECURITY GROUPS-------------------------------------------
#RDS VPC SG
resource "aws_security_group" "rds_security_group" {
  #  name        = "RDSSecurityGroup"
  description = "Security group for RDS in build infra account"
  # provider    = aws.build-infra
 vpc_id      = var.vpc_id
  # Example: Allow incoming traffic on port 443.
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    #security_groups = [data.aws_security_group.app_ecs_security_group.id, data.aws_security_group.app_lambda_security_group.id]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # Add more ingress rules if required
        tags = merge(
    local.tags, {"Name" = "${var.product}-${var.environment}-${var.resource_name}-RDS Security Group"}
  )
}
