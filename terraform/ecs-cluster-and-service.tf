resource "aws_ecs_cluster" "cluster_creation" {
    name="${var.project_name}-quickcart-cluster" 
}
#service for auth-container
resource "aws_ecs_service" "auth_service" {
    name="${var.project_name}-auth-svc"
    cluster = aws_ecs_cluster.cluster_creation.id
    task_definition = aws_ecs_task_definition.auth.arn
    desired_count = 1
    launch_type = "FARGATE"

    network_configuration {
        subnets = [aws_subnet.private_1.id,aws_subnet.private_2.id]
        security_groups = [aws_security_group.ecs_sg.id]
        assign_public_ip = "false"
    }
    load_balancer {
      target_group_arn = aws_lb_target_group.tg_auth.arn
      container_name = "auth-service"
      container_port = 5005
    }
    deployment_minimum_healthy_percent = 50
  deployment_maximum_percent         = 200
}
# service for payment container
resource "aws_ecs_service" "product_service" {
    name="${var.project_name}-product-svc"
    cluster = aws_ecs_cluster.cluster_creation.id
    task_definition = aws_ecs_task_definition.product.arn
    desired_count = 1
    launch_type = "FARGATE"

    network_configuration {
        subnets = [aws_subnet.private_1.id,aws_subnet.private_2.id]
        security_groups = [aws_security_group.ecs_sg.id]
        assign_public_ip = "false"
    }
    load_balancer {
      target_group_arn = aws_lb_target_group.tg_product.arn
      container_name = "product-service"
      container_port = 5001
    }
    deployment_minimum_healthy_percent = 50
  deployment_maximum_percent         = 200
}
#service for cart-container
resource "aws_ecs_service" "cart_service" {
    name="${var.project_name}-cart-svc"
    cluster = aws_ecs_cluster.cluster_creation.id
    task_definition = aws_ecs_task_definition.cart.arn
    desired_count = 1
    launch_type = "FARGATE"

    network_configuration {
        subnets = [aws_subnet.private_1.id,aws_subnet.private_2.id]
        security_groups = [aws_security_group.ecs_sg.id]
        assign_public_ip = "false"
    }
    load_balancer {
      target_group_arn = aws_lb_target_group.tg_cart.arn
      container_name = "cart-service"
      container_port = 5002
    }
    deployment_minimum_healthy_percent = 50
  deployment_maximum_percent         = 200
}
#service for order container 
resource "aws_ecs_service" "order_service" {
    name="${var.project_name}-order-svc"
    cluster = aws_ecs_cluster.cluster_creation.id
    task_definition = aws_ecs_task_definition.order.arn
    desired_count = 1
    launch_type = "FARGATE"

    network_configuration {
        subnets = [aws_subnet.private_1.id,aws_subnet.private_2.id]
        security_groups = [aws_security_group.ecs_sg.id]
        assign_public_ip = "false"
    }
    load_balancer {
      target_group_arn = aws_lb_target_group.tg_order.arn
      container_name = "order-service"
      container_port = 5003
    }
    deployment_minimum_healthy_percent = 50
  deployment_maximum_percent         = 200
}
#service for payment container
resource "aws_ecs_service" "payment_service" {
    name="${var.project_name}-payment-svc"
    cluster = aws_ecs_cluster.cluster_creation.id
    task_definition = aws_ecs_task_definition.payment.arn
    desired_count = 1
    launch_type = "FARGATE"

    network_configuration {
        subnets = [aws_subnet.private_1.id,aws_subnet.private_2.id]
        security_groups = [aws_security_group.ecs_sg.id]
        assign_public_ip = "false"
    }
    load_balancer {
      target_group_arn = aws_lb_target_group.tg_payment.arn
      container_name = "payment-service"
      container_port = 5004
    }
    deployment_minimum_healthy_percent = 50
  deployment_maximum_percent         = 200
}
#service for email container
resource "aws_ecs_service" "email_service" {
    name="${var.project_name}-email-svc"
    cluster = aws_ecs_cluster.cluster_creation.id
    task_definition = aws_ecs_task_definition.email.arn
    desired_count = 1
    launch_type = "FARGATE"

    network_configuration {
        subnets = [aws_subnet.private_1.id,aws_subnet.private_2.id]
        security_groups = [aws_security_group.ecs_sg.id]
        assign_public_ip = "false"
    }
    load_balancer {
      target_group_arn = aws_lb_target_group.tg_email.arn
      container_name = "email-service"
      container_port = 5006
    }
    deployment_minimum_healthy_percent = 50
  deployment_maximum_percent         = 200
}

  
