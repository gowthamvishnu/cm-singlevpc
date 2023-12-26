
output "vpc_id" {
  value = var.cm_vpc_id != "" ? var.cm_vpc_id : aws_vpc.cm_vpc[0].id
}

output "vpc_cidr" {
  value = "${aws_vpc.cm_vpc[*].cidr_block}"
}

output "private_subnets" {
  value = aws_subnet.private_subnets[*].id
}


output "private_subnets_cidr" {
  value = "${aws_subnet.private_subnets[*].cidr_block}"
}

output "rds_subnet_group_name" {
  value = aws_db_subnet_group.rds_subnet_group.name
}
