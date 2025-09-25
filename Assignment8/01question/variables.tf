variable "region" {
  default = "us-east-1"
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
  default     = "ami-0360c520857e3138f"  
}

variable "instance_type" {
  default = "t3.micro"
}

variable "key_name" {
  description = "Optional existing AWS key pair for SSH"
  default     = ""
}

variable "github_repo_url" {
  default = "https://github.com/sagarkundrapu/Assignment6.git"
}
