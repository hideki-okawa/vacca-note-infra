terraform {
  backend "s3" {
    bucket = "okawa-tfstate"
    key    = "vacca-note/view/main.tfstate"
    region = "ap-northeast-1"
  }
}