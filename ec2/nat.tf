# NAT gateway for private instances to access internet 
# USE IT IF DO NOT WANT YOUR INSTANCES TO BE ACCESSIBLE FROM INTERNET
/*
# static IP aws elastic IP
resource "aws_eip" "nat" {
  vpc = true
}

# private subnet
resource "aws_subnet" "main_private" {
  vpc_id                  = aws_vpc.main.id
  map_public_ip_on_launch = false
  cidr_block              = "192.168.2.0/24"
  availability_zone       = "eu-north-1c"
  tags = {
    Name = "main_private"
  }
}

# aws_nat_gateway
resource "aws_nat_gateway" "main_gw" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.main_public.id
  depends_on    = [aws_internet_gateway.main_gw.id]
}

# route table for private subnet
resource "aws_route_table" "main_private" {
  vpc_id = aws_vpc.mainvpc.id
  route {
    cidr_block  = "0.0.0.0/0"
    nat_gateway = aws_nat_gateway.main_gw.id
  }

  tags = {
    Name = "NAT_private_routing"
  }
}

# route table association with subnet
resource "aws_route_table_association" "main_private-1c" {
  route_table_id = aws_route_table.main_private.id
  subnet_id      = aws_subnet.main_private.id
}
*/