output "public_ip" {
  value       = aws_instance.app.public_ip
  description = "Public IP address of the EC2 instance"
}

output "instance_public_dns" {
  description = "Public DNS"
  value       = aws_instance.app.public_dns
}