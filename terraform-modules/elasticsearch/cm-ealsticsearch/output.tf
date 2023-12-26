output "elasticsearch_arn" {
  value = aws_elasticsearch_domain.test.arn
}

output "elasticsearch_endpoint" {
  value = aws_elasticsearch_domain.test.endpoint
}
