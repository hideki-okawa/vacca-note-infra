data "terraform_remote_state" "routing_main" {
  backend = "s3"

  config = {
    bucket = "okawa-tfstate"
    key    = "${local.system_name}/routing/main.tfstate"
    region = "ap-northeast-1"
  }
}