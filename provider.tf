provider "aws" {
  region = "ap-northeast-1"
}

# プロバイダーとしてAWSを使用
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.42.0"
    }
  }

  required_version = "1.1.9"
}