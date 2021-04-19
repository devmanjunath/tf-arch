resource "aws_db_instance" "myRDS" {
  allocated_storage           = 20
  engine                      = "sqlserver-ex"
  engine_version              = "15.00.4073.23.v1"
  instance_class              = "db.t3.small"
#   name                        = var.RDS-Name
  username                    = var.RDS-User
  password                    = var.RDS-Password
#   parameter_group_name        = "default.mysql5.7"
  skip_final_snapshot         = true
  deletion_protection         = false
  allow_major_version_upgrade = false
  auto_minor_version_upgrade  = false
  port                        = 1433
  storage_type                = "gp2"
  multi_az                    = false
  db_subnet_group_name        = aws_db_subnet_group.rds-SG.name
  vpc_security_group_ids      = [data.terraform_remote_state.vpc.outputs.rdsSG]
}

resource "aws_db_subnet_group" "rds-SG" {
  name       = "rdssg"
  subnet_ids = [data.terraform_remote_state.vpc.outputs.private-1a, data.terraform_remote_state.vpc.outputs.private-2a]

  tags = {
    Name = "RDS Subnet Group"
  }
}
