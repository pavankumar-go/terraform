# Additional storage for ec2 instance

# elastic block storage with general purpose ssd of size 20GB
resource "aws_ebs_volume" "secondary" {
  availability_zone = var.availability_zone
  size              = 8
  type              = "gp2"
  tags = {
    Name = "volume-1"
  }
}

# ebs volume attachment to ec2 instance
resource "aws_volume_attachment" "ebs_secondary" {
  device_name = var.aws_ebs_volume_name
  volume_id   = aws_ebs_volume.secondary.id
  instance_id = aws_instance.ubuntu.id
  # force_detach = true
}
