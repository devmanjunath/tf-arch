variable "Key_pair" {
  default = "Cloudbreathe"
}

variable "region" {
  default = "ap-south-1"
}

variable "name" {
  default = "Core Music"
}

variable "ami-id" {
  default = "ami-0d758c1134823146a"
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
