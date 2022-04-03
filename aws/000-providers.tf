terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
  }
}

provider "aws" {
  #access_key = ""
  #secret_key = ""
  region  = "eu-west-3"
}