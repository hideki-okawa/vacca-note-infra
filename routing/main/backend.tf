terraform {
  backend "s3" {
    bucket = "okawa-tfstate"
    key    = "vacca-note/routing/main.tfstate"
    region = "ap-northeast-1"
  }
}