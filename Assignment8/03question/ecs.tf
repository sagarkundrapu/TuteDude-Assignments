resource "aws_ecs_cluster" "main" {
  name = "app-cluster"
}

resource "aws_ecs_task_definition" "flask_backend" {
  family                   = "flask-backend"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_task_role.arn 
  
  container_definitions = jsonencode([{
    name      = "flask_backend"
    image     = var.flask_image
    essential = true
    portMappings = [{
      containerPort = 5000
    }]
  }])
}

resource "aws_ecs_task_definition" "express_frontend" {
  family                   = "express-frontend"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_task_role.arn 

  container_definitions = jsonencode([{
    name      = "express_frontend"
    image     = var.express_image
    essential = true
    portMappings = [{
      containerPort = 3000
    }]
    environment = [
      {
        name  = "BACKEND_URL"
        value = "http://${aws_lb.app_alb.dns_name}"
      }
    ]
  }])
}

resource "aws_ecs_service" "flask_backend" {
  name            = "flask-backend-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.flask_backend.arn
  launch_type     = "FARGATE"
  desired_count   = 1

  network_configuration {
    subnets         = module.vpc.public_subnets
    security_groups = [aws_security_group.ecs_sg.id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.flask_tg.arn
    container_name   = "flask_backend"
    container_port   = 5000
  }
}

resource "aws_ecs_service" "express_frontend" {
  name            = "express-frontend-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.express_frontend.arn
  launch_type     = "FARGATE"
  desired_count   = 1

  network_configuration {
    subnets         = module.vpc.public_subnets
    security_groups = [aws_security_group.ecs_sg.id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.express_tg.arn
    container_name   = "express_frontend"
    container_port   = 3000
  }

}