output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnets" {
  value = [aws_subnet.public_1.id, aws_subnet.public_2.id]
}

output "private_subnets" {
  value = [aws_subnet.private_1.id, aws_subnet.private_2.id]
}

output "rds_sg_id" {
  value = aws_security_group.RDS_sg.id
}

output "db_endpoint" {
  value = aws_db_instance.postgres.address
}

output "frontend_url" {
  value = aws_s3_bucket_website_configuration.static.website_endpoint
}

output "alb_sg_id" {
  value = aws_security_group.alb_sg.id
}
output "alb_dns_name" {
  description = "Application Load Balancer DNS URL"
  value       = aws_lb.app_alb.dns_name
}
