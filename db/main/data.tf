data "terraform_remote_state" "network_main" {
  backend = "s3"

  config = {
    bucket = "okawa-tfstate"
    key    = "${local.system_name}/network/main.tfstate"
    region = "ap-northeast-1"
  }
}

data "aws_kms_alias" "rds" {
  name = "alias/aws/rds"
}
