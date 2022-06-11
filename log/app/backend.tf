terraform {
  backend "s3" {
    bucket = "okawa-tfstate"
    key    = "vacca-note/log/app.tfstate"
    region = "ap-northeast-1"
  }
}