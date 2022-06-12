data "aws_ecs_service" "this" {
  cluster_arn  = "${local.system_name}"
  service_name = "${local.system_name}"
}