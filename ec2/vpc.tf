# vpc
resource "aws_vpc" "main" {
  enable_dns_hostnames = true
  enable_dns_support   = true
  cidr_block           = "192.168.0.0/16"
  tags = {
    Name = "main"
  }
}

# subnet
resource "aws_subnet" "main_public" {
  vpc_id                  = aws_vpc.main.id
  map_public_ip_on_launch = "true"
  cidr_block              = "192.168.1.0/24"
  availability_zone       = "eu-north-1c"
  tags = {
    Name = "main_public"
  }
}

# Internet Gateway for accessing instances from internet
resource "aws_internet_gateway" "main_gw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "main"
  }
}

# route requests from any IP to internet gateway
resource "aws_route_table" "main_public" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main_gw.id
  }
  tags = {
    Name = "main_public"
  }
}

# Associate route table to subnet 
resource "aws_route_table_association" "main_public-1c" {
  subnet_id      = aws_subnet.main_public.id
  route_table_id = aws_route_table.main_public.id
}
