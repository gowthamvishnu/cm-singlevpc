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

resource "aws_elasticsearch_domain" "test" {
  domain_name           = "cm-${var.environment}-elasticsearch"
  elasticsearch_version = var.elasticsearch_version #"7.10"
  cluster_config {
    instance_type = var.elasticsearch_instance_type #"t3.small.elasticsearch"
    #zone_awareness_enabled = true
    #instance_count         = 2
    dedicated_master_enabled = var.dedicated_master_enabled
    dedicated_master_count = var.dedicated_master_count
    dedicated_master_type = var.dedicated_master_type

  }
  ebs_options {
    ebs_enabled = var.elasticsearch_ebs_enabled
    volume_size = var.elasticsearch_volume_size
  }
  vpc_options {
    subnet_ids         = [var.subnet_id]
    security_group_ids = var.security_group_id
  }
  encrypt_at_rest {
    enabled = true
  }
  node_to_node_encryption {
    enabled = true
  }
  advanced_security_options {
    enabled = true
    master_user_options {
      master_user_arn = "${var.role_arn}"
    }
  }
  domain_endpoint_options {
    enforce_https = true
    tls_security_policy = "Policy-Min-TLS-1-0-2019-07"
  }

      tags = merge(
    local.tags, {"Name" = "${var.product}-${var.environment}-elasticSearch"}
  )
}
