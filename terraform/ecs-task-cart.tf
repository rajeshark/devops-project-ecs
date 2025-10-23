resource "aws_ecs_task_definition" "cart" {
  family                   = "${var.project_name}-cart-tsk"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"

  execution_role_arn = "arn:aws:iam::775826428475:role/ecsTaskExecutionRole"
  task_role_arn      = "arn:aws:iam::775826428475:role/ecsTaskExecutionRole"

  container_definitions = jsonencode([
    {
      name       = "cart-service"
      image      = "775826428475.dkr.ecr.ap-south-1.amazonaws.com/cart:latest"
      essential  = true
      portMappings = [
        {
          containerPort = 5002
          hostPort      = 5002
        }
      ]
      secrets = [
        { name = "JWT_SECRET", valueFrom = "arn:aws:secretsmanager:ap-south-1:775826428475:secret:/quickcart/backend/common-rL3fc5" },
        { name = "DB_PORT", valueFrom = "arn:aws:secretsmanager:ap-south-1:775826428475:secret:/quickcart/backend/common-rL3fc5" },
        { name = "DB_NAME", valueFrom = "arn:aws:secretsmanager:ap-south-1:775826428475:secret:/quickcart/backend/common-rL3fc5" },
        { name = "DB_USER", valueFrom = "arn:aws:secretsmanager:ap-south-1:775826428475:secret:/quickcart/backend/common-rL3fc5" },
        { name = "DB_PASSWORD", valueFrom = "arn:aws:secretsmanager:ap-south-1:775826428475:secret:/quickcart/backend/common-rL3fc5" },
        { name = "DB_HOST", valueFrom = "${aws_ssm_parameter.db_host.arn}" },
        { name = "NODE_ENV", valueFrom = "arn:aws:secretsmanager:ap-south-1:775826428475:secret:/quickcart/backend/common-rL3fc5" }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = "/ecs/${var.project_name}-cart"
          "awslogs-region"        = "ap-south-1"
          "awslogs-stream-prefix" = "ecs"
          "awslogs-create-group"  = "true"
        }
      }
    }
  ])
}
