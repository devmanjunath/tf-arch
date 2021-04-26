terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  profile                 = var.environment[terraform.workspace].profile
  region                  = var.environment[terraform.workspace].region
  shared_credentials_file = var.environment[terraform.workspace].credentials_file
}


terraform {
  backend "s3" {
    bucket  = "tfcb2021"
    region  = "ap-south-1"
    key     = "terraform.tfstate"
    encrypt = true
  }
}

module "vpc" {
  source = "./Modules/VPC"
}

module "ec2" {
  source = "./Modules/EC2"

  ## Variables for EC2
  ami-id    = var.ami[var.environment[terraform.workspace].region]["x86"].id
  ec2SG     = [module.vpc.security_groups["ec2SG"]]
  subnet-id = module.vpc.subnets.public[0]
}

module "scripts-wordpress" {
  source = "./Modules/Scripts Automation/EC2"

  public-ip = module.ec2.public_ip

  depends_on = [
    module.ec2
  ]
}
