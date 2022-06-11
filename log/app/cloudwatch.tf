resource "aws_cloudwatch_log_group" "app" {
  name = "/ecs/${local.system_name}/app"

  retention_in_days = 90
}