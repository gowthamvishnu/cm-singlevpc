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

resource "aws_iam_role" "lambda_execution_role" {
  name = "${var.product}-${var.environment}-${var.resource_name}-iam-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })

   tags = merge(
    local.tags, {"Name" = "${var.product}-${var.environment}-${var.resource_name}-iam-role"}
  )
}

data "archive_file" "lambda" {
  type        = "zip"
  source_file = "${path.module}/lambda.js"
  output_path = "lambda_function_payload.zip"
}

resource "aws_lambda_function" "cms_lambda" {
  filename      = "lambda_function_payload.zip"
  function_name = "${var.product}-${var.environment}-Lambda"
  runtime       = "nodejs18.x"
  handler       = "index.test"
  #vpc_config {
  #  subnet_ids         = var.subnet_ids
  #  security_group_ids = var.security_group_ids
  #}
  role = aws_iam_role.lambda_execution_role.arn
  tags = merge(
    local.tags, {"Name" = "${var.product}-${var.environment}-Lambda"}
  )
}

# resource "aws_connect_lambda_function_association" "example" {
#   function_arn = aws_lambda_function.example.arn
#   instance_id  = aws_connect_instance.example.id
# }


#--------------------------------------------------

# data "aws_iam_policy_document" "assume_role" {
#   statement {
#     effect = "Allow"

#     principals {
#       type        = "Service"
#       identifiers = ["lambda.amazonaws.com"]
#     }

#     actions = ["sts:AssumeRole"]
#   }
# }

# resource "aws_iam_role" "iam_for_lambda" {
#   name               = "iam_for_lambda"
#   assume_role_policy = data.aws_iam_policy_document.assume_role.json
# }

# data "archive_file" "lambda" {
#   type        = "zip"
#   source_file = "lambda.js"
#   output_path = "lambda_function_payload.zip"
# }

# resource "aws_lambda_function" "test_lambda" {
#   # If the file is not in the current working directory you will need to include a
#   # path.module in the filename.
#   filename      = "lambda_function_payload.zip"
#   function_name = "lambda_function_name"
#   role          = aws_iam_role.iam_for_lambda.arn
#   handler       = "index.test"

#   source_code_hash = data.archive_file.lambda.output_base64sha256

#   runtime = "nodejs18.x"

#   environment {
#     variables = {
#       foo = "bar"
#     }
#   }
# }

