#data "aws_vpc" "dmz" {
#  cidr_block = "10.12.0.0/16"
#}

# Data source to get the ID of the security group in the other account


#data "aws_security_group" "app_ecs_security_group" {
#  #provider = aws.aws_automation
#  name = "APP-ECSSecurityGroup"
#}
#data "aws_security_group" "app_lambda_security_group" {
#  #provider = aws.aws_automation
#  name = "APP-LAMBDASecurityGroup"
#}
#data "aws_security_group" "rds_vpc_security_group" {
#  provider = aws.build-infra
#  name     = "RDSSecurityGroup"
#}

