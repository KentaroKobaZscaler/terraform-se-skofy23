# 0. Random
resource "random_id" "random_id" {
    byte_length = 8
  # length  = 8
  # upper   = false
  # special = false
}


#Retrieve the list of AZs in the current AWS region
data "aws_availability_zones" "available" {}
data "aws_region" "current" {}

# Terraform Data Block - Lookup Ubuntu 20.04
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

# Creating an AWS VPC
module "vpc" {
   source               = "terraform-aws-modules/vpc/aws"
   name                 = "vpc-main"
   cidr                 = "10.0.0.0/16"
   azs                  = ["${var.aws_region}a", "${var.aws_region}b"]
   private_subnets      = ["10.0.0.0/24", "10.0.1.0/24"]
   public_subnets       = ["10.0.100.0/24", "10.0.101.0/24"]
   enable_dns_hostnames = true
   enable_dns_support   = true
   enable_nat_gateway   = false
   enable_vpn_gateway   = false
   tags = {
       Terraform   = "true"
       Environment = "dev-skofy23"
   }
}

# Creating a Security Group
resource "aws_security_group" "allow_ports" {
   name        = "allow_ssh_http"
   description = "Allow inbound SSH traffic and http from any IP"
   vpc_id      = "${module.vpc.vpc_id}"

   #ssh access
   ingress {
       from_port   = 22
       to_port     = 22
       protocol    = "tcp"
       # Restrict ingress to necessary IPs/ports.
       cidr_blocks = ["0.0.0.0/0"]
   }

   # HTTP access
   ingress {
       from_port   = 80
       to_port     = 80
       protocol    = "tcp"
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
   instance_type          = "${var.instance_type}"
   ami                    = "${lookup(var.aws_amis, var.aws_region)}"
   count                  = "${var.instance_count}"
   key_name               = "${aws_key_pair.skofy23.key_name}"
   vpc_security_group_ids = ["${aws_security_group.allow_ports.id}"]
   subnet_id              = "${element(module.vpc.public_subnets,count.index)}"
   user_data              = "${file("scripts/init.sh")}"
   tags = {
    Name = "SKOFY23-Lab03"
  }
    depends_on = [ local_file.private_key_pem ]
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
    content = tls_private_key.generated.private_key_pem
    filename = "SKOFY23AWSKey.pem"
}