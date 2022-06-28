###################################################
#### Define provider
###################################################
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
  }
}

###################################################
#### Define credentials for AWS
###################################################
provider "aws" {
  #access_key = ""
  #secret_key = ""
  region  = "eu-west-3"
}

###################################################
#### Check for "available" Availability Zones (AZ)
###################################################
data "aws_availability_zones" "available" {
  state = "available"
}