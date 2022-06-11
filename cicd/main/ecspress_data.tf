data "aws_lb_target_group" "this" {
  name = "${local.system_name}-app"
}

data "aws_security_group" "vpc" {
  name = "${local.system_name}-main-vpc"
}

data "aws_subnet" "private_a" {
  tags = {
    Name = "${local.system_name}-main-private-a"
  }
}

data "aws_subnet" "private_c" {
  tags = {
    Name = "${local.system_name}-main-private-c"
  }
}

data "aws_ecr_repository" "app" {
  name   = "${local.system_name}-app"
}

data "aws_iam_role" "ecs_task" {
  name = "${local.system_name}-ecs-task"
}

data "aws_iam_role" "ecs_task_execution" {
   name = "${local.system_name}-ecs-task-execution"
}

data "aws_cloudwatch_log_group" "app" {
   name = "/ecs/${local.system_name}/app"
}