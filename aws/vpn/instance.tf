resource "aws_key_pair" "mykey" {
  key_name   = "vpnkey"
  public_key = file(var.public_key_path)
}

resource "aws_instance" "ubuntu_vpn_server" {
  tags = {
    Name = "Ubuntu VPN Server"
  }
  instance_type = var.instance_type
  ami           = var.ubuntu_machine_id
  key_name      = aws_key_pair.mykey.key_name
  subnet_id     = aws_subnet.private.id
  # public_ip = aws_eip.vpnserver_ip.public_ip
  vpc_security_group_ids = [aws_security_group.vpnserver.id]
  availability_zone      = var.availability_zone
}