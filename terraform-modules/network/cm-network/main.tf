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

# CM VPC
resource "aws_vpc" "cm_vpc" {
  count      = var.cm_vpc_id != "" ? 0 : 1
  cidr_block = var.cm_vpc_cidr_block #"10.12.0.0/16"
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames
  instance_tenancy     = var.instance_tenancy

  tags = merge(
    local.tags, {"Name" = "${var.product}-${var.environment}-CM VPC"}
  )
 
}

resource "aws_default_security_group" "default" {
  vpc_id = var.cm_vpc_id != "" ? var.cm_vpc_id : aws_vpc.cm_vpc[0].id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    local.tags, {"Name" = "${var.product}-${var.environment}-CM Default SG"}
  )
}


###############################################################
# Private subntes
################################################################
resource "aws_subnet" "private_subnets" {
  count = var.create_subnets ? ( can("${length(var.existing_subnet_ids)}" == "0") ? 2 : 0) : 0
  vpc_id            = var.cm_vpc_id != "" ? var.cm_vpc_id : aws_vpc.cm_vpc[0].id
  cidr_block        = cidrsubnet(var.cm_vpc_cidr_block, 11, count.index)
 availability_zone = length(regexall("^[a-z]{2}-", element(var.azs, count.index))) > 0 ? element(var.azs, count.index) : null
 tags = merge(
    local.tags, {"Name" = format("${var.customer}-${var.environment}-${var.product}-private-%s", count.index+1)}
  )
}


###############################################################
# Nat Gateway
################################################################
resource "aws_eip" "nat_gateway_ip" {
  count = var.create_nat_gw ? 1 : 0
  domain   = "vpc"

  tags = merge(
    local.tags, {"Name" = "${var.customer}-${var.environment}-${var.product}-nat-eip"}
  )
}

resource "aws_nat_gateway" "nat_gateway" {
  count = var.create_nat_gw ? 1 : 0
  allocation_id = aws_eip.nat_gateway_ip[0].id
  subnet_id     = "${aws_subnet.private_subnets[0].id}"
  tags = merge(
    local.tags, {"Name" = "${var.customer}-${var.environment}-${var.product}-nat-gw"}
  )
  depends_on = [aws_eip.nat_gateway_ip]
}

################################################################
# Private Route Table
################################################################
resource "aws_route_table" "private_route_table" {
    vpc_id            = var.cm_vpc_id != "" ? var.cm_vpc_id : aws_vpc.cm_vpc[0].id
  tags = merge(
    local.tags, {"Name" = "${var.customer}-${var.environment}-${var.product}-private-rt"}
  )
}


resource "aws_route" "private_route_nat" {
  count = var.create_nat_gw ? 1 : 0
  route_table_id         = aws_route_table.private_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_nat_gateway.nat_gateway[count.index].id
}

resource "aws_route_table_association" "private_rt_association" {
  count = var.create_subnets ? ( can("${length(var.existing_subnet_ids)}" == "0") ? 2 : 0) : 0
  #count = var.create_subnets && length(var.existing_subnet_ids) == 0 ? 2 : 0
  subnet_id      = aws_subnet.private_subnets[count.index].id #"${aws_subnet.private_subnet[count.index].id}"
  route_table_id = aws_route_table.private_route_table.id
}

################################################################################
# Private Network ACLs
################################################################################
resource "aws_network_acl" "private_nacl" {
  vpc_id     = var.cm_vpc_id != "" ? var.cm_vpc_id : aws_vpc.cm_vpc[0].id
  subnet_ids = aws_subnet.private_subnets[*].id
  egress {
    protocol   = "all"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port = "0"
    to_port = "0"
  }
  ingress {
    protocol   = "all"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port = "0"
    to_port = "0"
  }

 tags = merge(
    local.tags, {"Name" = "${var.customer}-${var.environment}-${var.product}-private-nacl"}
  )
}

################################################################################
# RDS Subnet group
################################################################################

#Subnet Group for RDS

resource "aws_db_subnet_group" "rds_subnet_group" {
  description = "RDS DB subnet group"
  # provider    = aws.build-infra
  subnet_ids  = var.private_subnets_for_dbgroup #[aws_subnet.private_subnets[0].id, aws_subnet.private_subnets[1].id]
tags = merge(
    local.tags, {"Name" = "${var.product}-${var.environment}-RDS-db-subnet-group"}
  )
}


#######################################################################################
#  ECS ENDPOINT
#######################################################################################

resource "aws_vpc_endpoint" "ecs_agent_endpoint" {
  vpc_id     = var.cm_vpc_id != "" ? var.cm_vpc_id : aws_vpc.cm_vpc[0].id
  vpc_endpoint_type = "Interface"
  service_name = "com.amazonaws.${var.aws_region}.ecs-agent"
  private_dns_enabled = true
  # other attributes...
}
resource "aws_vpc_endpoint" "ecs_telemetry_endpoint" {
 
  vpc_id     = var.cm_vpc_id != "" ? var.cm_vpc_id : aws_vpc.cm_vpc[0].id
  vpc_endpoint_type = "Interface"
  service_name = "com.amazonaws.${var.aws_region}.ecs-telemetry"
  private_dns_enabled = true
  # other attributes...
}
resource "aws_vpc_endpoint" "ecs_endpoint" {
  vpc_id     = var.cm_vpc_id != "" ? var.cm_vpc_id : aws_vpc.cm_vpc[0].id
  vpc_endpoint_type = "Interface"
  service_name = "com.amazonaws.${var.aws_region}.ecs"
  private_dns_enabled = true
  # other attributes...
}
resource "aws_vpc_endpoint_subnet_association" "ecs_telemetry_association" {
  subnet_id        =  length(var.existing_subnet_ids) > 0 ? var.existing_subnet_ids[0] : aws_subnet.private_subnets[0].id
  vpc_endpoint_id    = aws_vpc_endpoint.ecs_agent_endpoint.id
}
resource "aws_vpc_endpoint_subnet_association" "ecs_association" {
  subnet_id        = length(var.existing_subnet_ids) > 0 ? var.existing_subnet_ids[0] : aws_subnet.private_subnets[0].id
  vpc_endpoint_id    = aws_vpc_endpoint.ecs_telemetry_endpoint.id
}
resource "aws_vpc_endpoint_subnet_association" "subnet_association" {
  subnet_id        = length(var.existing_subnet_ids) > 0 ? var.existing_subnet_ids[0] : aws_subnet.private_subnets[0].id
  vpc_endpoint_id    = aws_vpc_endpoint.ecs_endpoint.id
}









