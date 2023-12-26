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


################################################################################
# CM-APP ECS Cluster
################################################################################
resource "aws_ecs_cluster" "app_cluster" {
  name = "${var.product}-${var.environment}-app-ecs-cluster"
  tags = merge(
    local.tags, {"Name" = "${var.product}-${var.environment}-app-ecs-cluster"}
  )
}

resource "aws_ecs_capacity_provider" "app_cluster" {
  name = "${var.product}-${var.environment}-app-ecs-capacity"
  depends_on = [
    aws_autoscaling_group.cm_app_asg
  ]
  auto_scaling_group_provider {
    auto_scaling_group_arn         = aws_autoscaling_group.cm_app_asg.arn
    managed_termination_protection = "DISABLED"
  }
  tags = merge(
    local.tags, {"Name" = "${var.product}-${var.environment}-app-ecs-Capacity"}
  )
}

resource "aws_autoscaling_group" "cm_app_asg" {
  name                = "${var.product}-${var.environment}-app-ecs-ASG"
  vpc_zone_identifier = var.subnet
  target_group_arns   = [aws_lb_target_group.cm-app.arn]
  min_size            = var.cm_app_min_size
  max_size            = var.cm_app_max_size
  desired_capacity    = var.cm_app_desired_capacity
  launch_template {
    id      = aws_launch_template.cm_app_lt.id
    version = "$Latest"
  }
  
  tag {
    key                 = "environment"
    value               = "${var.environment}"
    propagate_at_launch = true
  }
  tag {
    key                 = "Region"
    value               = "${var.aws_region}"
    propagate_at_launch = true
  }
  tag {
    key                 = "requestor"
    value               = "${var.requestor}"
    propagate_at_launch = true
  }
  tag {
    key                 = "customer"
    value               = "${var.customer}"
    propagate_at_launch = true
  }
  tag {
    key                 = "tenant"
    value               = "${var.tenant}"
    propagate_at_launch = true
  }
  tag {
    key                 = "product"
    value               = "${var.product}"
    propagate_at_launch = true
  }
  tag {
    key                 = "manager"
    value               = "${var.manager}"
    propagate_at_launch = true
  }
  tag {
    key                 = "owner"
    value               = "${var.owner}"
    propagate_at_launch = true
  }
  tag {
    key                 = "purpose"
    value               = "${var.purpose}"
    propagate_at_launch = true
  }
  tag {
    key                 = "Name"
    value               = "${var.product}-${var.environment}-app-ecs-ASG"
    propagate_at_launch = true
  }

}

resource "aws_launch_template" "cm_app_lt" {
  name_prefix   = "${var.product}-${var.environment}-app-ecs-LT"
  image_id      = var.ami_id != "" ? var.ami_id : data.aws_ami.lt_image[0].id
  instance_type = var.cm_app_instance_type
  iam_instance_profile {
    name = var.iam_instance_profile
  }
  block_device_mappings {
    device_name = "/dev/sdf"
    ebs {
      volume_size = "${var.ecs_volume_size}"
    }
  }
  network_interfaces {
    security_groups = var.security_group_id
    associate_public_ip_address = false
  }
  #user_data = filebase64("${path.module}/user_data.sh") #data.template_file.userdata.rendered
  user_data     = "${base64encode(<<EOF
    #!/bin/bash
    echo ECS_CLUSTER= "${var.product}-${var.environment}-app-ecs-cluster" >> /etc/ecs/ecs.config
    EOF
  )}"
  # Specify the instance name and tags
  instance_initiated_shutdown_behavior = "stop"
  tag_specifications {
    resource_type = "instance"
    tags = merge(
    local.tags, {"Name" = "${var.product}-${var.environment}-app-ecs-LT"}
    )
  }
  key_name = var.ecs_lt_key_name
}

# resource "tls_private_key" "cm_app_lt_key" {
#   algorithm = "RSA"
#   rsa_bits  = 4096
# }

# resource "aws_key_pair" "cm_app_lt_key" {
#   key_name   = "${var.product}-${var.environment}-app-ecs-lt-key"
#   public_key = tls_private_key.cm_app_lt_key.public_key_openssh

#   tags = merge(
#     local.tags, {"Name" = "${var.product}-${var.environment}-app-ecs-lt-key"}
#   )
# }


resource "aws_ecs_task_definition" "cm-app" {
  family = "${var.product}-${var.environment}-app-ecs-td"
  network_mode             = "bridge"
  requires_compatibilities = ["EC2"]
  tags = merge(
    local.tags, {"Name" = "${var.product}-${var.environment}-app-ecs-td"}
    )
  container_definitions = jsonencode([
    {
      name              = "${var.product}-${var.environment}-app-ecs-td-container"
      image             = "${var.cm_app_ecs_image}" #"techtieracorp/cm-app:latest"
      memoryReservation = 128
      portMappings = [
        {
          containerPort = "${var.cm_app_container_port}"
          hostPort      = "${var.cm_app_container_port}"
        }
      ]
    }
  ])
}
resource "aws_lb_target_group" "cm-app" {
  name     = "${var.product}-${var.environment}-app-ecs-TG"
  port     = var.cm_app_container_port
  protocol = var.target_group_protocol
  vpc_id   = var.vpc_id
   tags = merge(
    local.tags, {"Name" = "${var.product}-${var.environment}-app-ecs-TG"}
    )
}

resource "aws_lb_listener_rule" "cm-app" {
  listener_arn = var.httplistnerarn
  priority     = 1
  tags = merge(
    local.tags, {"Name" = "${var.product}-${var.environment}-app-ecs-ALB-Listener"}
    )
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.cm-app.arn
  }
  condition {
    path_pattern {
      values = ["/api/*", "/js/minified.js", "/mailer/*", "/attachments/*"]
    }
  }
}
resource "aws_ecs_service" "cm-app-service" {
  cluster         = aws_ecs_cluster.app_cluster.id     # ECS Cluster ID
  # desired_count   = 1                                  # Number of tasks running
  launch_type     = "EC2"                              # Cluster type [ECS OR FARGATE]
  name            = "${var.product}-${var.environment}-app-ecs-Service"                   # Name of service
  task_definition = aws_ecs_task_definition.cm-app.arn # Attach the task to service
  scheduling_strategy = "DAEMON"
  load_balancer {
    container_name   = "${var.product}-${var.environment}-app-ecs-td-container"
    container_port   = var.cm_app_container_port
    target_group_arn = aws_lb_target_group.cm-app.arn
  }
  depends_on = [
    aws_lb_target_group.cm-app,
    aws_lb_listener_rule.cm-app,
  ]
  tags = merge(
    local.tags, {"Name" = "${var.product}-${var.environment}-app-ecs-Service"}
    )
}


################################################################################
# CM-Utilities ECS Cluster
################################################################################
resource "aws_ecs_cluster" "utilities_cluster" {
  name = "${var.product}-${var.environment}-utilities-ecs-cluster"
  tags = merge(
    local.tags, {"Name" = "${var.product}-${var.environment}-utilities-ecs-cluster"}
  )
}


resource "aws_autoscaling_group" "cm_utilities_asg" {
  name                = "${var.product}-${var.environment}-utilities-ecs-ASG"
  vpc_zone_identifier = var.subnet
  target_group_arns   = [aws_lb_target_group.cm-web.arn,
                        aws_lb_target_group.fetcher.arn,
                        aws_lb_target_group.central.arn,
                        aws_lb_target_group.onboard.arn,
                        aws_lb_target_group.report.arn
                        ]
  min_size            = var.cm_utilities_min_size
  max_size            = var.cm_utilities_max_size
  desired_capacity    = var.cm_utilities_desired_capacity
  launch_template {
    id      = aws_launch_template.cm_utilities_lt.id
    version = "$Latest"
  }
  
  tag {
    key                 = "environment"
    value               = "${var.environment}"
    propagate_at_launch = true
  }
  tag {
    key                 = "Region"
    value               = "${var.aws_region}"
    propagate_at_launch = true
  }
  tag {
    key                 = "requestor"
    value               = "${var.requestor}"
    propagate_at_launch = true
  }
  tag {
    key                 = "customer"
    value               = "${var.customer}"
    propagate_at_launch = true
  }
  tag {
    key                 = "tenant"
    value               = "${var.tenant}"
    propagate_at_launch = true
  }
  tag {
    key                 = "product"
    value               = "${var.product}"
    propagate_at_launch = true
  }
  tag {
    key                 = "manager"
    value               = "${var.manager}"
    propagate_at_launch = true
  }
  tag {
    key                 = "owner"
    value               = "${var.owner}"
    propagate_at_launch = true
  }
  tag {
    key                 = "purpose"
    value               = "${var.purpose}"
    propagate_at_launch = true
  }
  tag {
    key                 = "Name"
    value               = "${var.product}-${var.environment}-utilities-ecs-ASG"
    propagate_at_launch = true
  }

}

resource "aws_launch_template" "cm_utilities_lt" {
  name_prefix   = "${var.product}-${var.environment}-utilities-ecs-LT"
  image_id      = var.ami_id != "" ? var.ami_id : data.aws_ami.lt_image[0].id
  instance_type = var.cm_utilities_instance_type
  iam_instance_profile {
    name = var.iam_instance_profile
  }
  block_device_mappings {
    device_name = "/dev/sdf"
    ebs {
      volume_size = "${var.ecs_volume_size}"
    }
  }
  network_interfaces {
    security_groups = var.security_group_id
  }
  # user_data = filebase64("${path.module}/user_data.sh") #data.template_file.userdata.rendered
  user_data     = "${base64encode(<<EOF
    #!/bin/bash
    echo ECS_CLUSTER= "${var.product}-${var.environment}-utilities-ecs-cluster" >> /etc/ecs/ecs.config
    EOF
  )}"

  # Specify the instance name and tags
  instance_initiated_shutdown_behavior = "stop"
  tag_specifications {
    resource_type = "instance"
    tags = merge(
    local.tags, {"Name" = "${var.product}-${var.environment}-utilities-ecs-LT"}
    )
  }
  key_name = var.ecs_lt_key_name
}

# resource "tls_private_key" "cm_utilities_lt_key" {
#   algorithm = "RSA"
#   rsa_bits  = 4096
# }

# resource "aws_key_pair" "cm_utilities_lt_key" {
#   key_name   = "${var.product}-${var.environment}-utilities-ecs-lt-key"
#   public_key = tls_private_key.cm_app_lt_key.public_key_openssh

#   tags = merge(
#     local.tags, {"Name" = "${var.product}-${var.environment}-utilities-ecs-lt-key"}
#   )
# }


#-----------------------------------------------------------------------------------------
#CM-WEB
resource "aws_ecs_task_definition" "cm-web" {
  family                   = "${var.product}-${var.environment}-utilities-WEB-TD"
  requires_compatibilities = ["EC2"]
  network_mode             = "bridge"
    tags = merge(
    local.tags, {"Name" = "${var.product}-${var.environment}-utilities-WEB-TD"}
    )
  container_definitions = jsonencode([
    {
      name              = "${var.product}-${var.environment}-utilities-WEB-Container"
      image             = "${var.cm_web_ecs_image}"      #"techtieracorp/cm-web:latest"
      memoryReservation = 128
      portMappings = [
        {
          containerPort = "${var.cm_web_container_port}"
          hostPort      = "${var.cm_web_container_port}"
        }
      ]
    }
  ])
}

resource "aws_lb_target_group" "cm-web" {
  name     = "${var.product}-${var.environment}-utilities-WEB-TG"
  port     = var.cm_web_container_port
  protocol = var.target_group_protocol
  vpc_id   = var.vpc_id
      tags = merge(
    local.tags, {"Name" = "${var.product}-${var.environment}-utilities-WEB-TG"}
    )
}

resource "aws_lb_listener_rule" "cm-web" {
  listener_arn = var.app_alb_listener_2_arn
  priority     = 2
  tags = merge(
    local.tags, {"Name" = "${var.product}-${var.environment}-utilities-WEB-Listener"}
    )

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.cm-web.arn
  }
  condition {
    host_header {
      values = ["cm${var.environment}.ondotsystems.com"]
    }
  }
}

resource "aws_ecs_service" "cm-web-service" {
  cluster         = aws_ecs_cluster.utilities_cluster.id     # ECS Cluster ID
  # desired_count   = 1                                  # Number of tasks running
  launch_type     = "EC2"                              # Cluster type [ECS OR FARGATE]
  name            = "${var.product}-${var.environment}-utilities-WEB-Service"                   # Name of service
  task_definition = aws_ecs_task_definition.cm-web.arn # Attach the task to service
  scheduling_strategy = "DAEMON"
  load_balancer {
    container_name   = "${var.product}-${var.environment}-utilities-WEB-Container"
    container_port   = var.cm_web_container_port
    target_group_arn = aws_lb_target_group.cm-web.arn
  }
  depends_on = [
    aws_lb_target_group.cm-web,
    aws_lb_listener_rule.cm-web,
  ]
    tags = merge(
    local.tags, {"Name" = "${var.product}-${var.environment}-ECS-CM-WEB-Service"}
    )

}

#-----------------------------------------------------------------------------------------------
#Fetcher
resource "aws_ecs_task_definition" "fetcher" {
  family                   = "${var.product}-${var.environment}-utilities-Fetcher-TD"
  requires_compatibilities = ["EC2"]
  network_mode             = "bridge"
      tags = merge(
    local.tags, {"Name" = "${var.product}-${var.environment}-utilities-Fetcher-TD"}
    )
  container_definitions = jsonencode([
    {
      name              = "${var.product}-${var.environment}-utilities-Fetcher-Container"
      image             = "${var.fetcher_ecs_image}" #"techtieracorp/fetcher:latest"
      memoryReservation = 128
      portMappings = [
        {
          containerPort = "${var.cm_fetcher_container_port}"
          hostPort      = "${var.cm_fetcher_container_port}"
        }
      ]
    }
  ])
}

resource "aws_lb_target_group" "fetcher" {
  name     = "${var.product}-${var.environment}-utilities-Fetcher-TG"
  port     = var.cm_fetcher_container_port
  protocol = var.target_group_protocol
  vpc_id   = var.vpc_id
  tags = merge(
    local.tags, {"Name" = "${var.product}-${var.environment}-utilities-Fetcher-TG"}
    )
}

resource "aws_lb_listener_rule" "fetcher" {
  listener_arn = var.httplistnerarn
  priority     = 3
    tags = merge(
    local.tags, {"Name" = "${var.product}-${var.environment}-utilities-Fetcher-Listener"}
    )
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.fetcher.arn
  }
  condition {
    path_pattern {
      values = ["/fetcher/*"]
    }
  }
}

resource "aws_ecs_service" "fetcher-service" {
  cluster         = aws_ecs_cluster.utilities_cluster.id
  # desired_count   = 1
  launch_type     = "EC2"
  name            = "${var.product}-${var.environment}-utilities-Fetcher-Service"
  task_definition = aws_ecs_task_definition.fetcher.arn
  scheduling_strategy = "DAEMON"
  load_balancer {
    container_name   = "${var.product}-${var.environment}-utilities-Fetcher-Container"
    container_port   = var.cm_fetcher_container_port
    target_group_arn = aws_lb_target_group.fetcher.arn
  }
  depends_on = [
    aws_lb_target_group.fetcher,
    aws_lb_listener_rule.fetcher,
  ]
      tags = merge(
    local.tags, {"Name" = "${var.product}-${var.environment}-utilities-Fetcher-Service"}
    )
}

#---------------------------------------------------------------------------
#Central
resource "aws_ecs_task_definition" "central" {
  family                   = "${var.product}-${var.environment}-utilities-Central-TD"
  requires_compatibilities = ["EC2"]
  network_mode             = "bridge"
        tags = merge(
    local.tags, {"Name" = "${var.product}-${var.environment}-utilities-Central-TD"}
    )

  container_definitions = jsonencode([
    {
      name              = "${var.product}-${var.environment}-utilities-central-Container"
      image             = "${var.central_ecs_image}"  #"techtieracorp/central:latest"
      memoryReservation = 128
      portMappings = [
        {
          containerPort = "${var.cm_central_container_port}"
          hostPort      = "${var.cm_central_container_port}"
        }
      ]
    }
  ])
}

resource "aws_lb_target_group" "central" {
  name     = "${var.product}-${var.environment}-utilities-Central-TG"
  port     = var.cm_central_container_port
  protocol = var.target_group_protocol
  vpc_id   = var.vpc_id
  tags = merge(
    local.tags, {"Name" = "${var.product}-${var.environment}-utilities-Central-TG"}
    )
}

resource "aws_lb_listener_rule" "central" {
  listener_arn = var.httplistnerarn
  priority     = 4
    tags = merge(
    local.tags, {"Name" = "${var.product}-${var.environment}-utilities-Central-Listener"}
    )

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.central.arn
  }
  condition {
    path_pattern {
      values = ["/central/*"]
    }
  }
}

resource "aws_ecs_service" "central" {
  cluster         = aws_ecs_cluster.utilities_cluster.id      # ECS Cluster ID
  # desired_count   = 1                                   # Number of tasks running
  launch_type     = "EC2"                               # Cluster type [ECS OR FARGATE]
  name            = "${var.product}-${var.environment}-utilities-Central-Service"               # Name of service
  task_definition = aws_ecs_task_definition.central.arn # Attach the task to service
  scheduling_strategy = "DAEMON"
  load_balancer {
    container_name   = "${var.product}-${var.environment}-utilities-central-Container"
    container_port   = var.cm_central_container_port
    target_group_arn = aws_lb_target_group.central.arn
  }
  depends_on = [
    aws_lb_target_group.central,
    aws_lb_listener_rule.central,
  ]
      tags = merge(
    local.tags, {"Name" = "${var.product}-${var.environment}-utilities-Central-Service"}
    )

}

#-------------------------------------------------------------------------------------
#Onboard
resource "aws_ecs_task_definition" "onboard" {
  family                   = "${var.product}-${var.environment}-utilities-Onboard-TD"
  requires_compatibilities = ["EC2"]
  network_mode             = "bridge"
        tags = merge(
    local.tags, {"Name" = "${var.product}-${var.environment}-utilities-Onboard-TD"}
    )

  container_definitions = jsonencode([
    {
      name              = "${var.product}-${var.environment}-utilities-Onboard-Container"
      image             = "${var.onboard_ecs_image}"  #"techtieracorp/onboard:latest"
      memoryReservation = 128
      portMappings = [
        {
          containerPort = "${var.cm_onboard_container_port}"
          hostPort      = "${var.cm_onboard_container_port}"
        }
      ]
    }
  ])
}

resource "aws_lb_target_group" "onboard" {
  name     = "${var.product}-${var.environment}-utilities-Onboard-TG"
  port     = var.cm_onboard_container_port
  protocol = var.target_group_protocol
  vpc_id   = var.vpc_id
          tags = merge(
    local.tags, {"Name" = "${var.product}-${var.environment}-utilities-Onboard-TG"}
    )

}

resource "aws_lb_listener_rule" "onboard" {
  listener_arn = var.httplistnerarn
  priority     = 5
            tags = merge(
    local.tags, {"Name" = "${var.product}-${var.environment}-utilities-Onboard-Listener"}
    )

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.onboard.arn
  }
  condition {
    path_pattern {
      values = ["/onboard/*"]
    }
  }
}

resource "aws_ecs_service" "onboard" {
  cluster         = aws_ecs_cluster.utilities_cluster.id      # ECS Cluster ID
  # desired_count   = 1                                   # Number of tasks running
  launch_type     = "EC2"                               # Cluster type [ECS OR FARGATE]
  name            = "${var.product}-${var.environment}-utilities-Onboard-Service"                  # Name of service
  task_definition = aws_ecs_task_definition.onboard.arn # Attach the task to service
  scheduling_strategy = "DAEMON"
  load_balancer {
    container_name   = "${var.product}-${var.environment}-utilities-Onboard-Container"
    container_port   = var.cm_onboard_container_port
    target_group_arn = aws_lb_target_group.onboard.arn
  }
  depends_on = [
    aws_lb_target_group.onboard,
    aws_lb_listener_rule.onboard,
  ]
  tags = merge(
    local.tags, {"Name" = "${var.product}-${var.environment}-utilities-Onboard-Service"}
    )

}

#---------------------------------------------------------------------------------
#Report
resource "aws_ecs_task_definition" "report" {
  family                   = "${var.product}-${var.environment}-utilities-Report-TD"
  requires_compatibilities = ["EC2"]
  network_mode             = "bridge"
    tags = merge(
    local.tags, {"Name" = "${var.product}-${var.environment}-utilities-Report-TD"}
    )
  
  container_definitions = jsonencode([
    {
      name              = "${var.product}-${var.environment}-utilities-Report-Container"
      image             = "${var.report_ecs_image}"  #"techtieracorp/report:latest"
      memoryReservation = 128
      portMappings = [
        {
          containerPort = "${var.cm_report_container_port}"
          hostPort      = "${var.cm_report_container_port}"
        }
      ]
    }
  ])
}

resource "aws_lb_target_group" "report" {
  name     = "${var.product}-${var.environment}-utilities-Report-TG"
  port     = var.cm_report_container_port
  protocol = var.target_group_protocol
  vpc_id   = var.vpc_id
    tags = merge(
    local.tags, {"Name" = "${var.product}-${var.environment}-utilities-Report-TG"}
    )
}

resource "aws_lb_listener_rule" "report" {
  listener_arn = var.httplistnerarn
  priority     = 6
      tags = merge(
    local.tags, {"Name" = "${var.product}-${var.environment}-utilities-Report-Listener"}
    )
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.report.arn
  }
  condition {
    path_pattern {
      values = ["/report/*"]
    }
  }
}

resource "aws_ecs_service" "report" {
  cluster         = aws_ecs_cluster.utilities_cluster.id    # ECS Cluster ID
  # desired_count   = 1                                  # Number of tasks running
  launch_type     = "EC2"                              # Cluster type [ECS OR FARGATE]
  name            = "${var.product}-${var.environment}-utilities-Report-Service"                  # Name of service
  task_definition = aws_ecs_task_definition.report.arn # Attach the task to service
  scheduling_strategy = "DAEMON"
  load_balancer {
    container_name   = "${var.product}-${var.environment}-utilities-Report-Container"
    container_port   = var.cm_report_container_port
    target_group_arn = aws_lb_target_group.report.arn
  }
  depends_on = [
    aws_lb_target_group.report,
    aws_lb_listener_rule.report,
  ]
        tags = merge(
    local.tags, {"Name" = "${var.product}-${var.environment}-utilities-Report-Service"}
    )

}

