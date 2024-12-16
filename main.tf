terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

# Fetch the latest Ubuntu AMI in the region
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical's AWS account ID
  filter {
    name   = "name"
    values = ["ubuntu/images/*ubuntu-focal-20.04-amd64-server-*"]
  }
  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}

resource "aws_instance" "first" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"

  # User data to install Hello World HTML 1
  user_data = <<-EOT
              #!/bin/bash
              apt-get update -y
              apt-get install -y apache2
              echo "<html><body><h1>Hello World 1 from Terraform!</h1></body></html>" > /var/www/html/index.html
              sudo systemctl start apache2
              sudo systemctl enable apache2
              EOT
}

resource "aws_instance" "second" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"

  # User data to install Hello World HTML 2
  user_data = <<-EOT
              #!/bin/bash
              apt-get update -y
              apt-get install -y apache2
              echo "<html><body><h1>Hello World 2 from Terraform!</h1></body></html>" > /var/www/html/index.html
              sudo systemctl start apache2
              sudo systemctl enable apache2
              EOT
}