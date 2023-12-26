# Output the security group IDs for NLB and ALB in DMZ VPC
# output "dmz_nlb_security_group_id" {
#   value = aws_security_group.dmz_nlb_security_group.id
# }

# output "dmz_alb_security_group_id" {
#   value = aws_security_group.dmz_alb_security_group.id
# }

# Output the security group IDs in APP VPC
# output "app_nlb_security_group_id" {
#   value = aws_security_group.app_nlb_security_group.id
# }
output "app_alb_security_group_id" {
  value = aws_security_group.app_alb_security_group.id
}
output "app_nat_security_group_id" {
  value = aws_security_group.app_nat_security_group.id
}
output "app_redis_security_group_id" {
  value = aws_security_group.app_redis_security_group.id
}
output "app_rabbit_security_group_id" {
  value = aws_security_group.app_rabbit_security_group.id
}
output "app_ecs_security_group_id" {
  value = aws_security_group.app_ecs_security_group.id
}
output "app_kms_security_group_id" {
  value = aws_security_group.app_kms_security_group.id
}
output "app_lambda_security_group_id" {
  value = aws_security_group.app_lambda_security_group.id
}
output "app_logstash_security_group_id" {
  value = aws_security_group.app_logstash_security_group.id
}
output "app_elastic_security_group_id" {
  value = aws_security_group.app_elastic_security_group.id
}
output "app_efs_security_group_id" {
  value = aws_security_group.app_efs_security_group.id
}
# output "app_bastion_security_group_id" {
#   value = aws_security_group.app_bastion_security_group.id
# }


#Output the security group IDs in RDS VPC
output "rds_security_group_id" {
  value = aws_security_group.rds_security_group.id
}
