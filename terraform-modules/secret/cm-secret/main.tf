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


resource "aws_secretsmanager_secret" "secret1" {
  name = "/ondot/cm/${var.environment}/cmapp.properties"
  force_overwrite_replica_secret = true
  recovery_window_in_days = var.recovery_window_in_days
  
  tags = merge(
    local.tags, {"Name" = "/ondot/cm/${var.environment}/cmapp.properties"}
  )
}

resource "aws_secretsmanager_secret" "secret2" {
  name = "/ondot/cm/${var.environment}/cmweb.properties"
  force_overwrite_replica_secret = true
  recovery_window_in_days = var.recovery_window_in_days

  tags = merge(
    local.tags, {"Name" = "/ondot/cm/${var.environment}/cmweb.properties"}
  )
}

resource "aws_secretsmanager_secret" "secret3" {
  name = "/ondot/cm/${var.environment}/cmreport.properties"
  force_overwrite_replica_secret = true
  recovery_window_in_days = var.recovery_window_in_days

  tags = merge(
    local.tags, {"Name" = "/ondot/cm/${var.environment}/cmreport.properties"}
  )
}

resource "aws_secretsmanager_secret" "secret4" {
  name = "/ondot/cm/${var.environment}/fetcher.properties"
  force_overwrite_replica_secret = true
  recovery_window_in_days = var.recovery_window_in_days

  tags = merge(
    local.tags, {"Name" = "/ondot/cm/${var.environment}/fetcher.properties"}
  )
}

resource "aws_secretsmanager_secret" "secret5" {
  name = "/ondot/cm/${var.environment}/cmonboard.properties"
  force_overwrite_replica_secret = true
  recovery_window_in_days = var.recovery_window_in_days

  tags = merge(
    local.tags, {"Name" = "/ondot/cm/${var.environment}/cmonboard.properties"}
  )
}

resource "aws_secretsmanager_secret" "secret6" {
  name = "/ondot/cm/${var.environment}/central.properties"
  force_overwrite_replica_secret = true
  recovery_window_in_days = var.recovery_window_in_days

  tags = merge(
    local.tags, {"Name" = "/ondot/cm/${var.environment}/central.properties"}
  )
}