terraform {
  backend "s3" {
    bucket = "okawa-tfstate"
    key    = "vacca-note/cicd/main.tfstate"
    region = "ap-northeast-1"
  }
}