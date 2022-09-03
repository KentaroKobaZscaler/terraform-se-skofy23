terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
    http = {
        source = "hashicorp/http"
        version = "2.1.0"
    }
    random = {
        source = "hashicorp/random"
        version = "3.1.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "2.1.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "3.1.0"
    }
  }
}

provider "aws" {
  region = "ap-southeast-1"
#  region = "ca-central-1"
}

resource "random_id" "random_id" {
    byte_length = 8
  # length  = 8
  # upper   = false
  # special = false
}

# Creating a Security Group
resource "aws_security_group" "allow_ports" {
  name        = "allow_ssh_http"
  description = "Allow inbound SSH traffic and http from any IP"
  #    vpc_id      = "${module.vpc.vpc_id}"
    vpc_id = vpc-037106ee015adc135

  #ssh access
  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    # Restrict ingress to necessary IPs/ports.
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTP access
  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    # Restrict ingress to necessary IPs/ports.
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "skofy23_webserver" {
  instance_type          = var.instance_type
  ami                    = lookup(var.aws_amis, var.aws_region)
  count                  = var.instance_count
  key_name               = "${aws_key_pair.skofy23.key_name}"
  vpc_security_group_ids = ["${aws_security_group.allow_ports.id}"]
  #    subnet_id              = "${element(module.vpc.public_subnets,count.index)}"
  user_data = file("scripts/init.sh")
  tags = {
    Name = "SKOFY23-Lab02"
  }
  depends_on = [local_file.private_key_pem]
}

# Create AWS Key Pair
resource "aws_key_pair" "skofy23" {
key_name = "${var.key_name}${random_id.random_id.hex}"
  public_key = tls_private_key.generated.public_key_openssh
}

# Generate the RSA Private Key
resource "tls_private_key" "generated" {
  algorithm = "RSA"
}

# Store the Private Key Locallly
resource "local_file" "private_key_pem" {
  content  = tls_private_key.generated.private_key_pem
  filename = "SKOFY23AWSKey.pem"
}
