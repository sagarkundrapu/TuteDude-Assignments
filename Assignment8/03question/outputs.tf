output "app_url" {
  description = "Base URL to access the Flask app via ALB"
  value       = "http://${aws_lb.app_alb.dns_name}"
}

output "frontend_url" {
  value = "http://${aws_lb.app_alb.dns_name}/"
}

output "backend_url" {
  value = "http://${aws_lb.app_alb.dns_name}/api"
}


