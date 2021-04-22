resource "aws_instance" "core_music" {
  ami             = var.ami-id
  instance_type   = var.instance-type
  key_name        = var.Key_pair
  security_groups = var.ec2SG
  subnet_id       = var.subnet-id
  root_block_device {
    delete_on_termination = true
    volume_size = 8
  }

  tags = {
    Name = var.name
  }
}
