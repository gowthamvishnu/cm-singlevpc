output "secret_arns" {
  value = [aws_secretsmanager_secret.secret1.arn,
           aws_secretsmanager_secret.secret2.arn,
           aws_secretsmanager_secret.secret3.arn,
           aws_secretsmanager_secret.secret4.arn,
           aws_secretsmanager_secret.secret5.arn,
           aws_secretsmanager_secret.secret6.arn
           ]
}