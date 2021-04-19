resource "aws_instance" "core_music" {
  ami             = var.ami-id
  instance_type   = "t2.micro"
  key_name        = var.Key_pair
  security_groups = [data.terraform_remote_state.vpc.outputs.ec2SG]
  subnet_id       = data.terraform_remote_state.vpc.outputs.public-1a
  root_block_device {
    delete_on_termination = true
    volume_size = 8
  }

  tags = {
    Name = var.name
  }
}
