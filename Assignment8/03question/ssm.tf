resource "aws_ssm_parameter" "backend_url" {
  name  = "/app/backend_url"
  type  = "String"
  value = "http://${aws_lb.app_alb.dns_name}/api"
}