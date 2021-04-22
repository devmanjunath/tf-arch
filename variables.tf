variable "environment" {
  default = {
    "dev" = {
      profile          = "dev"
      region           = "ap-south-1"
      credentials_file = "C:\\Users\\manju\\.aws\\credentials"
    }

    "prod" = {
      profile          = "prod"
      region           = "ap-south-1"
      credentials_file = "C:\\Users\\manju\\.aws\\credentials"
    }
  }
}

variable "ami-id" {
  type    = string
}

variable "instance-type"{
  type = string
}

variable "public-ip"{
    default = ""
}