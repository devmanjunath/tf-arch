output "vpc_id" {
  description = "Public IP address of the EC2 instance"
  value       = aws_vpc.myVPC.id
}

output "subnets" {
  description = "Public IP address of the EC2 instance"
  value = {
    public  = [aws_subnet.public-1a.id, aws_subnet.public-2a.id]
    private = [aws_subnet.private-1a.id, aws_subnet.private-2a.id]
  }
}

output "security_groups" {
  description = "Public IP address of the EC2 instance"
  value = {
    ec2SG = aws_security_group.ec2.id
    rdsSG = aws_security_group.rds.id
    elbSG = aws_security_group.elb.id
  }
}