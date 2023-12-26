output "lambda_function_arn" {
  description = "The ARN (Amazon Resource Name) of the AWS Lambda function."
  value       = aws_lambda_function.cms_lambda.arn
}
