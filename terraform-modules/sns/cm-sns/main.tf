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

# Create an SNS topic
resource "aws_sns_topic" "SNS" {
  #name = "sns-topic"
        tags = merge(
    local.tags, {"Name" = "${var.product}-${var.environment}-SNS Topic"}
  )
}

# Define an email subscription
resource "aws_sns_topic_subscription" "email_subscription" {
  topic_arn = aws_sns_topic.SNS.arn
  protocol  = "email"
  endpoint  = "your.email@example.com" # Replace with your email address
}

# Define an SMS subscription
resource "aws_sns_topic_subscription" "sms_subscription" {
  topic_arn = aws_sns_topic.SNS.arn
  protocol  = "sms"
  endpoint  = "+1234567890" # Replace with your SMS number
}
