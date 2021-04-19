output "vpc_id" {
  description = "Public IP address of the EC2 instance"
  value       = aws_vpc.myVPC.id
}

output "public-1a" {
  description = "Public IP address of the EC2 instance"
  value       = aws_subnet.public-1a.id
}

output "public-2a" {
  description = "Public IP address of the EC2 instance"
  value       = aws_subnet.public-2a.id
}

output "private-1a" {
  description = "Public IP address of the EC2 instance"
  value       = aws_subnet.private-1a.id
}

output "private-2a" {
  description = "Public IP address of the EC2 instance"
  value       = aws_subnet.private-2a.id
}

output "rdsSG" {
  description = "Public IP address of the EC2 instance"
  value       = aws_security_group.rds.id
}

output "ec2SG" {
  description = "Public IP address of the EC2 instance"
  value       = aws_security_group.ec2.id
}

output "elbSG" {
  description = "Public IP address of the EC2 instance"
  value       = aws_security_group.elb.id
}