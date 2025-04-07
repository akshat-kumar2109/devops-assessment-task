terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.94.1"
    }
  }
}

provider "aws" {
  assume_role {
    role_arn = "arn:aws:iam::654654269997:role/terraform-role"
  }
  region = "us-east-1"
}