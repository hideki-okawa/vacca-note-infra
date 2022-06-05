terraform {
  backend "s3" {
    bucket = "okawa-tfstate"
    key    = "vacca-note/db/main.tfstate"
    region = "ap-northeast-1"
  }
}