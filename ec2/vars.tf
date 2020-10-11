variable "aws_region" {
  description = "AWS stockholm region to create things in."
  default     = "eu-north-1"
}

variable "public_key_path" {
  default = "ssh-keys/ec2key.pub"
}

variable "private_key_path" {
  default = "ssh-keys/ec2key.pem"
}

variable "aws_ec2_username" {
  default = "ubuntu"
}

variable "aws_ami" {
  description = "AWS ubuntu AMI ID"
  # https://cloud-images.ubuntu.com/locator/ec2/
  default = "ami-0199ab26ce7eaf0e0"
}

variable "os" {
  default = "ubuntu"
}

variable "env" {
  default = "test"
}

locals {
  name_prefix = "${var.os}-${var.env}"
}
