terraform {
  backend "s3" {
    bucket = "okawa-tfstate"
    key    = "vacca-note/log/alb.tfstate"
    region = "ap-northeast-1"
  }
}