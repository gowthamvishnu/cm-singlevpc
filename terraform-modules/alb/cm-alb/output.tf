# output "dmz_alb_dns_name" {
#   value = aws_lb.dmz_alb.dns_name
# }
# output "dmz_alb_arn" {
#   value = aws_lb.dmz_alb.arn
# }

output "app_alb_dns_name" {
  value = aws_lb.app_alb.dns_name
}
output "app_alb_arn" {
  value = aws_lb.app_alb.arn
}

#output "certlist" {
#  value = compact(split("\n", file("/home/ubuntu/Terraform/cm-migration-automation-modularized/nlb.txt")))
#}

#---------------------------------------------------------------------------------------------------------
# output "app_nlb_arn" {
#   value = aws_lb.app_network_lb.arn
# }
#output "nlb_null_id" {
#  value = null_resource.nlbip.id
#}
#
output "httplistnerarn" {
  value = aws_lb_listener.app_alb_listener_1.arn
}

output "app_alb_listener_2_arn" {
  value = aws_lb_listener.app_alb_listener_2.arn
}
