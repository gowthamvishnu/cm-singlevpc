output "api_gateway_url" {
  value = "https://${aws_api_gateway_rest_api.my_api.id}.execute-api.${var.aws_region}.amazonaws.com/prod"
}

output "api_gateway_id" {
  value = aws_api_gateway_rest_api.my_api.id
}
