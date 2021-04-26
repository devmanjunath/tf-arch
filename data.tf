data "aws_ami" "app_ami" {
  most_recent = true
  owners      = ["099720109477"]
  name_regex  = "([2-9][0-9])"

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-20210223"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}