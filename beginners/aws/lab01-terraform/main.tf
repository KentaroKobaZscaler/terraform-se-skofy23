terraform {
    required_version = ">= 1.0.0"
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~> 3.37"
        }
        local = {
            source = "hashicorp/local"
            version = "2.1.0"
        }
        tls = {
            source = "hashicorp/tls"
            version = "3.1.0"
        }
    }
}

provider "aws" {
    region = "us-east-1"
}

# Create single Ubuntu EC2 Instance
resource "aws_instance" "skofy23_webserver" {
    ami               = "ami-052efd3df9dad4825" #Ubuntu, Canonical 22.04 LTS X86 instance_type = "t2.micro"
    instance_type     = "t2.micro"
    # ami             = "ami-070650c005cce4203" #Ubuntu, Canonical 22.04 LTS ARM instance_type = "t2.micro"
    # instance_type   = "c6g.medium"
    key_name       = aws_key_pair.skofy23.key_name
  tags = {
    Name = "SKOFY23-Lab01"
  }
}

# Output Public IP
output "ip_addresses" {
   value = ["${aws_instance.skofy23_webserver.*.public_ip}"]
}

# Create AWS Key Pair
resource "aws_key_pair" "skofy23" {
    key_name = "SKOFY23AWSKey"
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