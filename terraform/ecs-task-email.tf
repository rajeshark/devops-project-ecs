resource "aws_ecs_task_definition" "email" {
  family                   = "${var.project_name}-email-tsk"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"

  execution_role_arn = "arn:aws:iam::775826428475:role/ecsTaskExecutionRole"
  task_role_arn      = "arn:aws:iam::775826428475:role/ecsTaskExecutionRole"

  container_definitions = jsonencode([
    {
      name       = "email-service"
      image      = "775826428475.dkr.ecr.ap-south-1.amazonaws.com/email:latest"
      essential  = true
      portMappings = [
        {
          containerPort = 5006
          hostPort      = 5006
        }
      ]
      secrets = [
        { name = "JWT_SECRET", valueFrom = "arn:aws:secretsmanager:ap-south-1:775826428475:secret:/quickcart/backend/common-rL3fc5:JWT_SECRET::" },
        { name = "NODE_ENV", valueFrom = "arn:aws:secretsmanager:ap-south-1:775826428475:secret:/quickcart/backend/common-rL3fc5:NODE_ENV::" }
      ]
      environment = [
        { name = "AWS_REGION", value = "ap-south-1" },
        { name = "S3_BUCKET_NAME", value = "devops-project-frontend-rajesh" },
        { name="EMAIL_USER", value="rajesha100920@gmail.com"},
        { name="EMAIL_PASSWORD",value="ijkl rtny jycm bvjc"}
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = "/ecs/${var.project_name}-email"
          "awslogs-region"        = "ap-south-1"
          "awslogs-stream-prefix" = "ecs"
          "awslogs-create-group"  = "true"
        }
      }
    }
  ])
}
