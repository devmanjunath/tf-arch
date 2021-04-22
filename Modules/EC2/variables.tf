variable "Key_pair" {
  default = "Cloudbreathe"
}

variable "name" {
  default = "Core Music"
}

variable "RDS-User" {
  default = "sa"
}

variable "RDS-Password" {
  default = "Admin#123"
}

variable "private_key_path" {
  default = "Cloudbreathe.pem"
}

## Assigned at Module level
variable "ec2SG" {}

variable "subnet-id" {}

variable "ami-id" {
  default = "ami-0d758c1134823146a"
}

variable "instance-type" {
  default = "t2.micro"
}
