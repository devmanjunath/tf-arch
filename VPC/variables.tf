variable "region" {
  type = "map"

  default = {
    us-east-1 = "image-1234"
    us-west-2 = "image-4567"
  }
}
variable "Key_pair" {
  default = "Cloudbreathe"
}

variable "RDS-Name" {
  default = "RDS-Core"
}

variable "private_key" {
  default = "Cloudbreathe.pem"
}

variable "RDS-User" {
  default = "sa"
}

variable "RDS-Password" {
  default = "Admin#123"
}
