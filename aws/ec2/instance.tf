# aws key pair for ssh connection to instance
resource "aws_key_pair" "ec2" {
  key_name   = "ubuntu_key_pair"
  public_key = file(var.public_key_path)
}

# aws instance with ubuntu os 
resource "aws_instance" "ubuntu" {
  instance_type               = var.instance_type
  ami                         = var.aws_ami
  key_name                    = aws_key_pair.ec2.key_name
  subnet_id                   = aws_subnet.main_public.id
  # private_ip = specify private to use or it will be auto assigned from the subnet
  vpc_security_group_ids      = [aws_security_group.allow_ssh_http.id]
  associate_public_ip_address = true
  availability_zone           = var.availability_zone

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

  # userdata that will be executed only during instance creation
  user_data = data.template_cloudinit_config.init_scripts.rendered

  tags = {
    Name = local.name_prefix
  }
}

/*
assign static public IP to ec2 instance
# static IP aws elastic IP
resource "aws_eip" "instance_public_ip" {
  instance = aws_instance.ubuntu.id
  vpc = true
}
*/