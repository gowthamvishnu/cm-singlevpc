# output "rabbit_arn" {
#   value = aws_mq_broker.rabbit_mq.arn
# }

# output "rabbit_id" {
#   value = aws_mq_broker.rabbit_mq.id
# }

# output "rabbit_config_arn" {
#   value = aws_mq_configuration.rabbit_mq.arn
# }

# output "rabbit_config_id" {
#   value = aws_mq_configuration.rabbit_mq.id
# }

output "rabbit_instance_id" {
  value = aws_instance.rabbit-instance.id
}

output "rabbit_private_ip" {
  value = aws_instance.rabbit-instance.private_ip
}

# output "public_key" {
#   value = tls_private_key.rabbit_key.public_key_openssh
# }
