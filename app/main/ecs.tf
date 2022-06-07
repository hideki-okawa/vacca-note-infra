resource "aws_ecs_cluster" "this" {
  name = "${local.system_name}"

  capacity_providers = [
    "FARGATE",
  ]

  tags = {
    Name = "${local.system_name}"
  }
}