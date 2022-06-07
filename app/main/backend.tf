terraform {
  backend "s3" {
    bucket = "okawa-tfstate"
    key    = "vacca-note/app/main.tfstate"
    region = "ap-northeast-1"
  }
}