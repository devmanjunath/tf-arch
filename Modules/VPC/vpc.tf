resource "aws_vpc" "myVPC" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = true 
  enable_dns_hostnames = true
  tags = {
    Name = "myVpc-${terraform.workspace}"
    Env  = "${terraform.workspace}"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.myVPC.id

  tags = {
    Name = "IGW-IGW"
    Env  = "${terraform.workspace}"
  }
}

resource "aws_subnet" "public-1a" {
  vpc_id                  = aws_vpc.myVPC.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "ap-south-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "Public 1A-myVPC"
    Env  = "${terraform.workspace}"
  }
}

resource "aws_subnet" "public-2a" {
  vpc_id                  = aws_vpc.myVPC.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "ap-south-1c"
  map_public_ip_on_launch = true

  tags = {
    Name = "Public 2A-myVPC"
    Env  = "${terraform.workspace}"
  }
}

resource "aws_subnet" "private-1a" {
  vpc_id            = aws_vpc.myVPC.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "ap-south-1a"

  tags = {
    Name = "Private 1A-myVPC"
    Env  = "${terraform.workspace}"
  }
}

resource "aws_subnet" "private-2a" {
  vpc_id            = aws_vpc.myVPC.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = "ap-south-1c"

  tags = {
    Name = "Private 2A-myVPC"
    Env  = "${terraform.workspace}"
  }
}

resource "aws_route_table" "rt1" {
  vpc_id = aws_vpc.myVPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "myVPC-RT1"
    Env  = "${terraform.workspace}"
  }
}

resource "aws_route_table_association" "rt1a" {
  subnet_id      = aws_subnet.public-1a.id
  route_table_id = aws_route_table.rt1.id
}

resource "aws_route_table_association" "rt2a" {
  subnet_id      = aws_subnet.public-2a.id
  route_table_id = aws_route_table.rt1.id
}

resource "aws_security_group" "ec2" {
  name        = "ec2-SG"
  description = "Security Group for EC2"
  vpc_id      = aws_vpc.myVPC.id
  ingress {
    description = "SSH Allow"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP Allow"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS Allow"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ec2-SG"
    Env  = "${terraform.workspace}"
  }
}

resource "aws_security_group" "rds" {
  name        = "RDS-SG"
  description = "Security Group for RDS"
  vpc_id      = aws_vpc.myVPC.id

  ingress {
    description     = "MSSQL Allow"
    from_port       = 1433
    to_port         = 1433
    protocol        = "tcp"
    self            = "true"
    security_groups = [aws_security_group.ec2.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    security_groups = [aws_security_group.ec2.id]
  }

  tags = {
    Name = "RDS-SG"
    Env  = "${terraform.workspace}"
  }
}

resource "aws_security_group" "elb" {
  name        = "elb-SG"
  description = "Security Group for ELB"
  vpc_id      = aws_vpc.myVPC.id

  tags = {
    Name = "elb-SG"
    Env  = "${terraform.workspace}"
  }
}
