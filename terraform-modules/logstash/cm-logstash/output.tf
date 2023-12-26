output "logstash_instance_id" {
  value = aws_instance.logstash-instance.id
}

output "logstash_private_ip" {
  value = aws_instance.logstash-instance.private_ip
}

# output "public_key" {
#   value = tls_private_key.logstash_key.public_key_openssh
# }

# output "private_key" {
#   value = tls_private_key.logstash_key.private_key_openssh
# }