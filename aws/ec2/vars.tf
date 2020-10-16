variable "aws_region" {
  description = "AWS stockholm region to create things in."
  default     = "eu-north-1"
}

variable "availability_zone" {
  default = "eu-north-1c"
}

variable "instance_type" {
  default = "t3.micro"
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

variable "aws_ebs_volume_name" {
  description = "Name of the additional ebs storage device"
  default     = "/dev/xvdf"
}

variable "cloudinit_script_path" {
  default = "scripts/cloud_init.cfg"
}

variable "mount_ebs_volume_script_path" {
  default = "scripts/mount_ebs_volume.sh"
}

/* 
This variable is sort of like a hack
Since instance type is of `T3` i.e., its a nitro system which exposes EBS volumes as NVMe block devices
The root device is /dev/nvme0n1.
The device names that you specify in a block device mapping are renamed using NVMe device names (/dev/nvme[0-26]n1).
eg: root /dev/sda1 will be renamed to /dev/nvme0m1
# https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/nvme-ebs-volumes.html
# https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ebs-using-volumes.html
*/
variable "ebs_device_name_hack" {
  default = "/dev/nvme1n1"
}
