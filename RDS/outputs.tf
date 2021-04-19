output "rds_endpoint" {
  description = "Public IP address of the EC2 instance"
  value       = aws_db_instance.myRDS.endpoint
}

output "rds_username" {
  description = "Public IP address of the EC2 instance"
  value       = aws_db_instance.myRDS.username
}

output "rds_password" {
  description = "Public IP address of the EC2 instance"
  sensitive = true
  value       = aws_db_instance.myRDS.password
}
