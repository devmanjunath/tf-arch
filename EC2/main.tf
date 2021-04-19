terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  profile = "default"
  region  = var.region
}

data "terraform_remote_state" "vpc" {
  backend = "local"

  config = {
    path = "../VPC/terraform.tfstate"
  }
}

# data "terraform_remote_state" "rds" {
#   backend = "local"

#   config = {
#     path = "../RDS/terraform.tfstate"
#   }
# }