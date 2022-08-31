variable "aws_region" {
#  default = "ap-southeast-1"
  default = "ca-central-1"
}

variable "instance_type" {
  description = "Type of AWS EC2 instance."
  default     = "t2.micro"
}

variable "aws_amis" {
  default = {
    ca-central-1 = "ami-0c802847a7dd848c0"
  }
}

variable "instance_count" {
  default = 1
}

variable "key_name" {
  description = "AWS Key Name"
  default     = "SKOFY23AWSKey"
}
