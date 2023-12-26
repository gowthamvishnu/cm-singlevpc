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

resource "aws_sqs_queue" "my_queue" {
  #name = "demo-queue"
  tags = merge(
    local.tags, {"Name" = "${var.product}-${var.environment}-Lambda-SQS"}
  )
}
