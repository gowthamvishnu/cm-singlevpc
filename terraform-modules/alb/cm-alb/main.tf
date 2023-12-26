locals {
  tags = {
    "environment" = "${var.environment}",
    "Region"      = "${var.aws_region}",
    "requestor"   = "${var.requestor}",
    "customer"    = "${var.customer}",
    "tenant"      = "${var.tenant}",
    "product"     = "${var.product}",
    "manager"     = "${var.manager}",
    "owner"       = "${var.owner}",
    "purpose"     = "${var.purpose}"
  }
}

# # DMZ VPC ALB ---------------------------------------------------------------
# resource "aws_lb" "dmz_alb" {
#   #  depends_on                 = [null_resource.dummy]
#   name                       = "${var.product}-${var.environment}-${var.resource_name}-DMZ-ALB"
#   internal                   = true
#   load_balancer_type         = "application"
#   subnets                    = var.dmz_alb_subnets
#   enable_http2               = true
#   enable_deletion_protection = false
#   security_groups            = var.security_group

#   tags = merge(
#     local.tags, { "Name" = "${var.product}-${var.environment}-${var.resource_name}-DMZ-ALB" }
#   )
# }

# resource "aws_lb_listener" "dmz_alb_listener" {
#   load_balancer_arn = aws_lb.dmz_alb.arn
#   port            = var.lb_listener_port     #443
#   protocol        = var.lb_listener_protocol #"HTTPS"
#   ssl_policy      = var.lb_listener_protocol == "HTTPS" ? var.ssl_policy : ""
#   certificate_arn = var.lb_listener_protocol == "HTTPS" ? var.certificate_arn : ""
#   default_action {
#     target_group_arn = aws_lb_target_group.dmz_alb_target_group.arn
#     type             = "forward"
#   }
#   # depends_on = [
#   #   aws_lb_listener.app_nlb_listener,
#   #   aws_lb_target_group_attachment.dmz_alb_attachment
#   # ]

#   tags = merge(
#     local.tags, { "Name" = "${var.product}-${var.environment}-${var.resource_name}-DMZ-ALB-Listener" }
#   )

# }

# # resource "aws_lb_listener" "my_listener_8443" {
# #  load_balancer_arn = aws_lb.dmz_alb.arn
# #  port            = var.lb_listener_port     #443
# #  protocol        = var.lb_listener_protocol #"HTTPS"
# #  ssl_policy      = var.lb_listener_protocol == "HTTPS" ? var.ssl_policy : ""
# #  certificate_arn = var.lb_listener_protocol == "HTTPS" ? var.certificate_arn : ""

# #  default_action {
# #    target_group_arn = aws_lb_target_group.dmz_alb_target_group.arn
# #    type             = "forward"
# #  }
# #  tags = {
# #    Name        = "${var.environment}-DMZ ALB TLS Listener"
# #  }
# # }

# resource "aws_lb_target_group" "dmz_alb_target_group" {
#   name        = "${var.product}-${var.environment}-${var.resource_name}-DMZ-ALB-Target-Group"
#   port     = var.lb_listener_port
#   protocol = var.lb_listener_protocol
#   vpc_id      = var.dmz_alb_vpc # Replace with your VPC ID
#   target_type = "ip"
#   #health_check {
#   #  protocol = "HTTP"
#   #  port     = 80
#   #  path     = "/"
#   #}
#   tags = merge(
#     local.tags, { "Name" = "${var.product}-${var.environment}-${var.resource_name}-DMZ-ALB-Target-Group" }
#   )

#   depends_on = [
#     aws_lb.dmz_alb,
#   ]
# }

# resource "aws_lb_target_group_attachment" "dmz_alb_attachment" {
#   count            = length(data.aws_network_interface.ifs.*.private_ips)
#   target_group_arn = aws_lb_target_group.dmz_alb_target_group.arn
#   #target_id = ["10.2.5.139", "10.2.6.101", "10.2.4.240"] #file("nlb.txt")
#   #target_id         = output.nlbips[count.index] #compact(split("\n", file(var.nlb_file_path)))[count.index]
#   target_id         = join("", data.aws_network_interface.ifs.*.private_ips[count.index])
#   availability_zone = "all"
#   port              = 80
#   # depends_on = [
#   #   aws_lb_target_group.dmz_alb_target_group,
#   #   data.aws_network_interfaces.this,
#   # ]
# }

#-----------------------------------------------------------------------------------------------------

#APP VPC ALB -------------------------------------
# resource "aws_lb" "app_alb" {
#   name                       = "${var.product}-${var.environment}-${var.resource_name}-APP-ALB"
#   internal                   = true
#   load_balancer_type         = "application"
#   subnets                    = var.app_alb_subnets
#   enable_http2               = true
#   enable_deletion_protection = false
#   security_groups            = var.app_security_group
#   tags = merge(
#     local.tags, { "Name" = "${var.product}-${var.environment}-${var.resource_name}-APP-ALB" }
#   )
# }

# resource "aws_lb_listener" "app_alb_listener_1" {
#   load_balancer_arn = aws_lb.app_alb.arn
#   port            = var.lb_listener_port     #443
#   protocol        = var.lb_listener_protocol #"HTTPS"
#   ssl_policy      = var.lb_listener_protocol == "HTTPS" ? var.ssl_policy : ""
#   certificate_arn = var.lb_listener_protocol == "HTTPS" ? var.certificate_arn : ""

#   default_action {
#     type = "fixed-response"

#     fixed_response {
#       content_type = "text/plain"
#       message_body = "Not Found"
#       status_code  = "404"
#     }
#   }
#   tags = merge(
#     local.tags, { "Name" = "${var.product}-${var.environment}-${var.resource_name}-APP-ALB-Listener" }
#   )
# }

# resource "aws_lb_target_group" "app_alb_target_group" {
#   name     = "${var.product}-${var.environment}-${var.resource_name}-APP-ALB-Target-Group"
#   port     = var.lb_listener_port
#   protocol = var.lb_listener_protocol
#   vpc_id   = var.alb_app_vpc
#   #target_type = "ip"
#   tags = merge(
#     local.tags, { "Name" = "${var.product}-${var.environment}-${var.resource_name}-APP-ALB-Target-Group" }
#   )
# }

resource "aws_lb" "app_alb" {
  name                       = "${var.product}-${var.environment}-APP-ALB"
  internal                   = true
  load_balancer_type         = "application"
  subnets                    = var.app_alb_subnets
  enable_http2               = true
  enable_deletion_protection = false
  security_groups            = var.app_security_group
  tags = merge(
    local.tags, { "Name" = "${var.product}-${var.environment}-APP-ALB" }
  )
}

resource "aws_lb_listener" "app_alb_listener_1" {
  load_balancer_arn = aws_lb.app_alb.arn
  port            = var.lb_listener_port     #443
  protocol        = var.lb_listener_protocol #"HTTPS"
  ssl_policy      = var.lb_listener_protocol == "HTTPS" ? var.ssl_policy : ""
  certificate_arn = var.lb_listener_protocol == "HTTPS" ? var.certificate_arn : ""

  default_action {
    type           = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      message_body = "Not Found"
      status_code  = "404"
    }
  }
  # default_action {
  #   type = "fixed-response"

  #   fixed_response {
  #     content_type = "text/plain"
  #     message_body = "Fixed response content"
  #     status_code  = "200"
  #   }
  # }
  tags = merge(
    local.tags, { "Name" = "${var.product}-${var.environment}-APP-ALB-Listener-443" }
  )
}

resource "aws_lb_listener" "app_alb_listener_2" {
  load_balancer_arn = aws_lb.app_alb.arn
  port            = 8443
  protocol        = var.lb_listener_protocol #"HTTPS"
  ssl_policy      = var.lb_listener_protocol == "HTTPS" ? var.ssl_policy : ""
  certificate_arn = var.lb_listener_protocol == "HTTPS" ? var.certificate_arn : ""

  default_action {
    type           = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      message_body = "Not Found"
      status_code  = "404"
    }
  }
  # default_action {
  #   type = "fixed-response"

  #   fixed_response {
  #     content_type = "text/plain"
  #     message_body = "Fixed response content"
  #     status_code  = "200"
  #   }
  # }
  tags = merge(
    local.tags, { "Name" = "${var.product}-${var.environment}-APP-ALB-Listener-8443" }
  )
}


resource "aws_lb_target_group" "app_alb_target_group_1" {
  name     = "${var.product}-${var.environment}-APP-ALB-TG-443"
  port     = var.lb_listener_port
  protocol = var.target_group_protocol
  vpc_id   = var.alb_app_vpc
  #target_type = "ip"
  tags = merge(
    local.tags, { "Name" = "${var.product}-${var.environment}-APP-ALB-TG-443" }
  )
}

resource "aws_lb_target_group" "app_alb_target_group_2" {
  name     = "${var.product}-${var.environment}-APP-ALB-TG-8443"
  port     = 8443
  protocol = var.target_group_protocol
  vpc_id   = var.alb_app_vpc
  #target_type = "ip"
  tags = merge(
    local.tags, { "Name" = "${var.product}-${var.environment}-APP-ALB-TG-8443" }
  )
}

