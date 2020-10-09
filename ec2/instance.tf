terraform {
    required_version = "~> 0.13.0"
}

resource "aws_key_pair" "key" {
	key_name = "ec2key"
	public_key = file(var.public_key_path)
}

resource "aws_instance" "ubuntu" {
	instance_type = "t3.micro"
	ami = var.aws_ami
	key_name = aws_key_pair.key.key_name
	subnet_id = aws_subnet.mainvpc_public_subnet.id
	vpc_security_group_ids = [aws_security_group.allow_ssh.id]
	associate_public_ip_address = true

	provisioner "file" {
		source = "scripts/init.sh"
		destination = "/tmp/init.sh"
		connection {
			type = "ssh"
			host = aws_instance.ubuntu.public_ip
			user = var.aws_ec2_username
			private_key = file(var.private_key_path)
		}
	}

	provisioner "remote-exec" {
		connection {
			type = "ssh"
			host = aws_instance.ubuntu.public_ip
			user = var.aws_ec2_username
			private_key = file(var.private_key_path)
		}
		inline = [
			"chmod +x /tmp/init.sh",
			"./tmp/init.sh"
		]
	}
}
