terraform {
  required_version = "~> 0.13.0"
}

# aws key pair for ssh connection to instance
resource "aws_key_pair" "ec2" {
  key_name   = "ubuntu_key_pair"
  public_key = file(var.public_key_path)
}

# aws instance with ubuntu os 
resource "aws_instance" "ubuntu" {
  instance_type               = "t3.micro"
  ami                         = var.aws_ami
  key_name                    = aws_key_pair.ec2.key_name
  subnet_id                   = aws_subnet.main_public.id
  vpc_security_group_ids      = [aws_security_group.allow_ssh_http.id]
  associate_public_ip_address = true

  provisioner "file" {
    connection {
      type        = "ssh"
      host        = aws_instance.ubuntu.public_ip
      user        = var.aws_ec2_username
      private_key = file(var.private_key_path)
    }
    source      = "scripts/init.sh"
    destination = "/tmp/init.sh"
  }

  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      host        = aws_instance.ubuntu.public_ip
      user        = var.aws_ec2_username
      private_key = file(var.private_key_path)
    }
    inline = [
      "chmod +x /tmp/init.sh",
      "/tmp/init.sh"
    ]
  }

  tags = {
    Name = local.name_prefix
  }
}
