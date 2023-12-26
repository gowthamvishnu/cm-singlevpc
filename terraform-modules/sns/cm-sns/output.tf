output "sns_topic_arn" {
  description = "The ARN of the created SNS topic"
  value       = aws_sns_topic.SNS.arn
}
