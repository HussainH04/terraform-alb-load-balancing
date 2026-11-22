output "alb_dns_name" {
  value = aws_lb.main.dns_name
}

output "url" {
  value = "http://${aws_lb.main.dns_name}"
}

output "target_group_arn" {
  value = aws_lb_target_group.web.arn
}

output "alb_sg_id" {
  value = aws_security_group.alb.id
}

output "instance_1_id" {
  value = aws_instance.web[0].id
}

output "instance_2_id" {
  value = aws_instance.web[1].id
}
