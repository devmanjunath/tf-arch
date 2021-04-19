terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

data "terraform_remote_state" "ec2" {
  backend = "local"

  config = {
    path = "../../EC2/terraform.tfstate"
  }
}

data "terraform_remote_state" "rds" {
  backend = "local"

  config = {
    path = "../../RDS/terraform.tfstate"
  }
}


