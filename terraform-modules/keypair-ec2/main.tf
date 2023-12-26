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


resource "tls_private_key" "private_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "ec2_key" {
  key_name   = "${var.product}-${var.environment}-ec2-key"
  public_key = tls_private_key.private_key.public_key_openssh

  tags = merge(
    local.tags, {"Name" = "${var.product}-${var.environment}-ec2-key"}
  )
}

