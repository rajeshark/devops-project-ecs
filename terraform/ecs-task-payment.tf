resource "aws_ecs_task_definition" "payment" {
  family                   = "${var.project_name}-payment-tsk"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"

  execution_role_arn = "arn:aws:iam::775826428475:role/ecsTaskExecutionRole"
  task_role_arn      = "arn:aws:iam::775826428475:role/ecsTaskExecutionRole"

  container_definitions = jsonencode([
    {
      name       = "payment-service"
      image      = "775826428475.dkr.ecr.ap-south-1.amazonaws.com/payment:latest"
      essential  = true
      portMappings = [
        {
          containerPort = 5004
          hostPort      = 5004
        }
      ]
      secrets = [
        { name = "JWT_SECRET", valueFrom = "arn:aws:secretsmanager:ap-south-1:775826428475:secret:/quickcart/backend/common-rL3fc5" },
        { name = "DB_PORT", valueFrom = "arn:aws:secretsmanager:ap-south-1:775826428475:secret:/quickcart/backend/common-rL3fc5" },
        { name = "DB_NAME", valueFrom = "arn:aws:secretsmanager:ap-south-1:775826428475:secret:/quickcart/backend/common-rL3fc5" },
        { name = "DB_USER", valueFrom = "arn:aws:secretsmanager:ap-south-1:775826428475:secret:/quickcart/backend/common-rL3fc5" },
        { name = "DB_PASSWORD", valueFrom = "arn:aws:secretsmanager:ap-south-1:775826428475:secret:/quickcart/backend/common-rL3fc5" },
        { name = "DB_HOST", valueFrom = "${aws_ssm_parameter.db_host.arn}" },
        { name = "ORDER_SERVICE_URL", valueFrom = "${aws_ssm_parameter.order_service_url.arn}" },
        { name = "NODE_ENV", valueFrom = "arn:aws:secretsmanager:ap-south-1:775826428475:secret:/quickcart/backend/common-rL3fc5" },
        { name = "STRIPE_PUBLISHABLE_KEY", valueFrom="arn:aws:secretsmanager:ap-south-1:775826428475:secret:/quickcart/backend/common-rL3fc5"},
        { name= "STRIPE_SECRET_KEY", valueFrom="arn:aws:secretsmanager:ap-south-1:775826428475:secret:/quickcart/backend/common-rL3fc5"},
        { name="STRIPE_WEBHOOK_SECRET",valueFrom="arn:aws:secretsmanager:ap-south-1:775826428475:secret:/quickcart/backend/common-rL3fc5"}
      ]
    }
  ])
}
