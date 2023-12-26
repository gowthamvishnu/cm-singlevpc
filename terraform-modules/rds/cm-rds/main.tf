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

# #--------------------------------------------------------------------------

# resource "aws_rds_cluster" "activepassive" {
#   cluster_identifier      = "${var.product}-${var.environment}-rds-cluster"
#   # provider                = aws.build-infra
#   engine                  = "aurora-mysql"
#   engine_version          = "5.7.mysql_aurora.2.11.2"    # Use the desired Aurora MySQL version
#   availability_zones      = ["us-east-1a", "us-east-1b"] # Replace with your desired AZs
#   database_name           = "exampledb"
#   master_username         = "admin"
#   master_password         = "YourStrongPassword" # Replace with a strong password
#   db_subnet_group_name    = var.db_subnet_group_name
#   vpc_security_group_ids  = [var.vpc_security_group_ids]
#   skip_final_snapshot     = true
#   backup_retention_period = 7
#       tags = merge(
#     local.tags, {"Name" = "${var.product}-${var.environment}-rds-cluster"}
#   )
# }

# resource "aws_rds_cluster_instance" "cluster_instances" {
#   count                = 1 # You can adjust the number of instances as needed
#   # provider             = aws.build-infra
#   identifier           = "${var.product}-${var.environment}-rds-cluster-instance-${count.index}"
#   engine               = "aurora-mysql"
#   engine_version       = "5.7.mysql_aurora.2.11.2" # Use the desired Aurora MySQL version
#   instance_class       = "db.t2.small"             # Adjust instance type as needed
#   db_subnet_group_name = var.db_subnet_group_name
#   cluster_identifier   = aws_rds_cluster.activepassive.id
#   depends_on           = [aws_rds_cluster.activepassive]
#        tags = merge(
#     local.tags, {"Name" = "${var.product}-${var.environment}-rds-cluster-instance-${count.index + 1}"}
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

#--------------------------------------------------------------------------

resource "aws_rds_cluster" "activepassive" {
  cluster_identifier      = "${var.product}-${var.environment}-rds-cluster"
  # provider                = aws.build-infra
  engine                  = var.rds_engine #"aurora-mysql"
  engine_version          = var.rds_engine_version #"5.7.mysql_aurora.2.11.2"    # Use the desired Aurora MySQL version
  availability_zones      = [var.azs[0], var.azs[1]] # Replace with your desired AZs
   database_name           = var.rds_database_name #"exampledb"
  master_username         = var.rds_master_username #"admin"
  master_password         = var.rds_master_password #"YourStrongPassword" # Replace with a strong password
  db_subnet_group_name    = var.db_subnet_group_name
  vpc_security_group_ids  = [var.vpc_security_group_ids]
  skip_final_snapshot     = true
  storage_encrypted       = true
  backup_retention_period = var.backup_retention_period #7
      tags = merge(
    local.tags, {"Name" = "${var.product}-${var.environment}-rds-cluster"}
  )
}

resource "aws_rds_cluster_instance" "cluster_instances" {
  count                = var.rds_instance_count # You can adjust the number of instances as needed
  # provider             = aws.build-infra
  identifier           = "${var.product}-${var.environment}-rds-cluster-instance-${count.index+1}"
  engine               = var.rds_engine #"aurora-mysql"
  engine_version       = var.rds_engine_version #"5.7.mysql_aurora.2.11.2" # Use the desired Aurora MySQL version
  instance_class       = var.rds_instance_class #"db.t2.small"
  availability_zone    = var.azs[count.index]
  cluster_identifier   = aws_rds_cluster.activepassive.id
  depends_on           = [aws_rds_cluster.activepassive]
       tags = merge(
    local.tags, {"Name" = "${var.product}-${var.environment}-rds-cluster-instance-${count.index+1}"}
  )

}
