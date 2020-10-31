resource "aws_vpc" "vpnserver" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "vpnserver"
  }
}

resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.vpnserver.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = var.availability_zone
  tags = {
    Name = "vpnserver"
  }
  map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "vpnserver" {
  vpc_id = aws_vpc.vpnserver.id
  tags = {
    Name = "vpnserver-gateway"
  }
}

resource "aws_route_table" "vpnserver" {
  vpc_id = aws_vpc.vpnserver.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.vpnserver.id
  }
  tags = {
    Name = "vpnserver-routetable"
  }
}


resource "aws_route_table_association" "vpnserver" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.vpnserver.id
}

resource "aws_eip" "vpnserver_ip" {
  instance = aws_instance.ubuntu_vpn_server.id
  vpc = true
}