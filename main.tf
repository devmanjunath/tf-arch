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
    bucket = "tfcb2021"
    region = "ap-south-1"
    key    = "terraform.dev.tfstate"
  }
}

module "vpc" {
  source = "./Modules/VPC"
}

module "ec2" {
  source = "./Modules/EC2"

  ## Variables for EC2
  ami-id        = var.ami-id == "" ? "ami-0d758c1134823146a" : var.ami-id
  instance-type = var.instance-type == "" ? "t2.micro" : var.instance-type
  ec2SG         = [module.vpc.security_groups["ec2SG"]]
  subnet-id     = module.vpc.subnets.public[0]
}

module "scripts-wordpress" {
  source = "./Modules/Scripts Automation/EC2"

  public-ip = module.ec2.public_ip

  depends_on = [
    module.ec2
  ]
}
