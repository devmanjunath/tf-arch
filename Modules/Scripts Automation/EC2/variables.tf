variable "private_key_path" {
  default = "C:\\Users\\manju\\.ssh\\Cloudbreathe.pem"
}

variable "mysql_config" {
  default = {
    host = "localhost",
    password = "Admin#123"
  }
}

variable "wordpress_config" {
  description = "Configuration for Wordpress credentials. Please use the settings used in wordpress.base.sql"
  default = {
    db       = "Wordpress"
    user     = "wp_user"
    password = "wp7102#56"
  }
}

## Assigned at Module level
variable "public-ip" {}

variable "ami-id" {
  default = "ami-0d758c1134823146a"
}

variable "instance-type" {
  default = "t2.micro"
}
