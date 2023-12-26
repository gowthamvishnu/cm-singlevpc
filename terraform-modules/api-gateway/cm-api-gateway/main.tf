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

resource "aws_api_gateway_rest_api" "my_api" {
  name        = "${var.product}-${var.environment}-API Gateway"
  description = var.api_description
  tags = merge(
    local.tags, {"Name" = "${var.product}-${var.environment}-API Gateway"}
  )
}
resource "aws_api_gateway_resource" "resource" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  parent_id   = aws_api_gateway_rest_api.my_api.root_resource_id
  path_part   = "myresource"
}
resource "aws_api_gateway_method" "method" {
  rest_api_id   = aws_api_gateway_rest_api.my_api.id
  resource_id   = aws_api_gateway_resource.resource.id
  http_method   = "GET"
  authorization = "NONE"
}


#resource "aws_lambda_permission" "api_gateway" {
#  statement_id  = "AllowExecutionFromAPIGateway"
#  action        = "lambda:InvokeFunction"
#  function_name = module.lambda_function.lambda_function_name
#  principal     = "apigateway.amazonaws.com"
#}
#
#resource "aws_api_gateway_integration" "integration" {
#  rest_api_id             = aws_api_gateway_rest_api.my_api.id
#  resource_id             = aws_api_gateway_resource.resource.id
#  http_method             = aws_api_gateway_method.method.http_method
#  integration_http_method = "POST"
#  type                    = "AWS_PROXY"
#  uri                     = module.lambda_function.lambda_function_invoke_arn
#}
#
#resource "aws_api_gateway_deployment" "deployment" {
#  depends_on = [aws_api_gateway_integration.integration]
#
#  rest_api_id = aws_api_gateway_rest_api.my_api.id
#  stage_name  = "prod"
#}
