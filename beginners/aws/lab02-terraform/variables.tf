variable "aws_region" {
  default = "eu-central-1"
}

variable "instance_type" {
  description = "Type of AWS EC2 instance."
  default     = "t2.micro"
}

variable "aws_amis" {
  default = {
    eu-central-1 = "ami-065deacbcaac64cf2"
  }
}

variable "instance_count" {
  default = 1
}

variable "key_name" {
  description = "AWS Key Name"
  default     = "SKOFY23AWSKey"
}