terraform {
  backend "s3" {
    bucket = "okawa-tfstate"
    key    = "vacca-note/network/main.tfstate"
    region = "ap-northeast-1"
  }
}