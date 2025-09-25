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
  name        = "tf-flask-express-sg"
  description = "Allow SSH, Flask(5000) and Express(3000)"
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

  ingress {
    description = "Flask backend"
    from_port   = 5000
    to_port     = 5000
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
    apt-get install -y git python3 python3-pip python3-venv curl build-essential

    # install Node.js (v18)
    curl -fsSL https://deb.nodesource.com/setup_18.x | bash -
    apt-get install -y nodejs

    # clone repo
    cd /home/ubuntu
    git clone ${var.github_repo_url}
    cd Assignment6                              

    # backend setup with venv
    cd backend
    sudo python3 -m venv venv
    . venv/bin/activate
    touch /home/ubuntu/flasklog.txt
    chmod 666 /home/ubuntu/flasklog.txt
    sudo chown -R ubuntu:ubuntu /home/ubuntu/Assignment6/backend/venv/

    pip install -r requirements.txt >> /home/ubuntu/flasklog.txt 2>&1

    nohup venv/bin/python app.py >> /home/ubuntu/flasklog.txt 2>&1 &

    # frontend setup
    cd ../frontend
    touch /home/ubuntu/expresslog.txt
    chmod 666 /home/ubuntu/expresslog.txt

    npm install --unsafe-perm >> /home/ubuntu/expresslog.txt 2>&1

    nohup node app.js >> /home/ubuntu/expresslog.txt 2>&1 &
EOF

  tags = {
    Name = "tf-flask-express-instance"
  }
}

