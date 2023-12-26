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

resource "aws_efs_file_system" "app_efs" {
  creation_token   = "${var.product}-${var.environment}-${var.resource_name}-App-EFS"
  performance_mode = "generalPurpose"
  throughput_mode  = "bursting"
  encrypted        = true
    tags = merge(
    local.tags, {"Name" = "${var.product}-${var.environment}-${var.resource_name}-App-EFS"}
  )
}

resource "aws_efs_mount_target" "efs_mount_target" {
  file_system_id  = aws_efs_file_system.app_efs.id
  #count           = length(var.subnet_ids)
  subnet_id       = var.subnet_id
  security_groups = var.security_group_ids
}
