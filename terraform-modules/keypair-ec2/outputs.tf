output "ec2_key_name" {
  value = aws_key_pair.ec2_key.key_name
}

output "public_key_openssh" {
  description = "The public key data in \"Authorized Keys\" format. This is populated only if the configured private key is supported: this includes all `RSA` and `ED25519` keys"
  value       = try(trimspace(tls_private_key.private_key.public_key_openssh), "")
}

output "public_key_pem" {
  description = "Public key data in PEM (RFC 1421) format"
  value       = try(trimspace(tls_private_key.private_key.public_key_pem), "")
}