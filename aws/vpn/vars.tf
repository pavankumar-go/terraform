variable "aws_region" {
  default     = "eu-north-1"
  description = "region to creare vpn server in."
}

variable "public_key_path" {
  description = "path to your public key"
  default     = "newkey.pub"
}

variable "private_key_path" {
  description = "path to your private key"
}

variable "instance_type" {
  default = "t3.micro"
}
variable "ubuntu_machine_id" {
# ubuntu 20.04 LTS
  default = "ami-0a3a4169ad7cb0d77"
}

variable "availability_zone" {
  default = "eu-north-1c"
}
