resource "aws_ssm_parameter" "db_host" {
  name  = "/quickcart/backend/db_host"
  type  = "String"
  value = aws_db_instance.postgres.address  # RDS endpoint
  tags = {
    Name = "quickcart-db-host"
  }
}

# Dynamic Order Service URL (from ALB DNS)
resource "aws_ssm_parameter" "order_service_url" {
  name  = "/quickcart/backend/order_service_url"
  type  = "String"
  value = "http://${aws_lb.app_alb.dns_name}"  # ALB DNS only
  tags = {
    Name = "quickcart-order-service-url"
  }
}
