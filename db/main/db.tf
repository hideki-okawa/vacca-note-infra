resource "aws_db_instance" "this" {
  engine         = "mysql"
  engine_version = "5.7.33"

  identifier = "${local.system_name}"

  username = "vaccanote"
  password = "mustchanegepassword" # ダミーのパスワード

  instance_class = "db.t3.micro"

  storage_type          = "gp2"
  allocated_storage     = 20
  max_allocated_storage = 0

  multi_az = false

  db_subnet_group_name = data.terraform_remote_state.network_main.outputs.db_subnet_group_name
  publicly_accessible  = false
  vpc_security_group_ids = [
    data.terraform_remote_state.network_main.outputs.security_group_db_app_id,
  ]
  availability_zone = "ap-northeast-1a"
  port              = 3306

  iam_database_authentication_enabled = false

  name                 = "vaccanote"
  parameter_group_name = aws_db_parameter_group.this.name
  option_group_name    = aws_db_option_group.this.name

  backup_retention_period  = 1
  backup_window            = "00:00-01:00"
  copy_tags_to_snapshot    = true
  delete_automated_backups = true
  skip_final_snapshot      = true

  storage_encrypted = true
  kms_key_id        = data.aws_kms_alias.rds.target_key_arn

  performance_insights_enabled = false
  # performance_insights_kms_key_id       = data.aws_kms_alias.rds.target_key_arn
  # performance_insights_retention_period = 7

  monitoring_interval = 60
  monitoring_role_arn = aws_iam_role.rds_monitoring_role.arn

  enabled_cloudwatch_logs_exports = [
    "error",
    "general",
    "slowquery"
  ]

  auto_minor_version_upgrade = false
  maintenance_window         = "fri:18:00-fri:19:00"

  deletion_protection = false

  tags = {
    Name = "${local.system_name}"
  }
}

resource "aws_db_parameter_group" "this" {
  name = "${local.system_name}"

  family = "mysql5.7"

  parameter {
    name  = "character_set_client"
    value = "utf8mb4"
  }

  parameter {
    name  = "character_set_connection"
    value = "utf8mb4"
  }

  parameter {
    name  = "character_set_database"
    value = "utf8mb4"
  }

  parameter {
    name  = "character_set_filesystem"
    value = "utf8mb4"
  }

  parameter {
    name  = "character_set_results"
    value = "utf8mb4"
  }

  parameter {
    name  = "character_set_server"
    value = "utf8mb4"
  }

  parameter {
    name  = "general_log"
    value = "1"
  }

  parameter {
    name  = "slow_query_log"
    value = "1"
  }

  parameter {
    name  = "long_query_time"
    value = "1.0"
  }

  parameter {
    name  = "log_output"
    value = "FILE"
  }

  tags = {
    Name = "${local.system_name}"
  }
}

resource "aws_db_option_group" "this" {
  name = "${local.system_name}"

  engine_name          = "mysql"
  major_engine_version = "5.7"

  tags = {
    Name = "${local.system_name}"
  }
}