terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.region
}

# default VPC lookup
data "aws_vpc" "default" {
  default = true
}

resource "aws_security_group" "instance_sg" {
  name        = "tf-flask-express-sg1"
  description = "Allow SSH, Express(3000)"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Express frontend"
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "app" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name != "" ? var.key_name : null
  vpc_security_group_ids = [aws_security_group.instance_sg.id]

  user_data = <<-EOF
    #!/bin/bash -xe
    apt-get update -y
    apt-get install -y git curl build-essential

    # install Node.js (v18)
    curl -fsSL https://deb.nodesource.com/setup_18.x | bash -
    apt-get install -y nodejs

    # clone repo
    cd /home/ubuntu
    git clone ${var.github_repo_url}
    cd Assignment6

    # frontend setup
    cd frontend
    touch /home/ubuntu/expresslog.txt
    chmod 666 /home/ubuntu/expresslog.txt

    sudo npm install --unsafe-perm >> /home/ubuntu/expresslog.txt 2>&1

    BACKEND_URL=http://3.95.181.194:5000 node app.js>> /home/ubuntu/expresslog.txt 2>&1 &
EOF

  tags = {
    Name = "tf-flask-express-instance"
  }
}

