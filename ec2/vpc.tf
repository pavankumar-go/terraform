# vpc
resource "aws_vpc" "mainvpc" {
  enable_dns_hostnames = true
  enable_dns_support   = true
  cidr_block           = "192.168.0.0/16"
  tags = {
    Name = "main"
  }
}

# subnet
resource "aws_subnet" "mainvpc_public_subnet" {
  vpc_id                  = aws_vpc.mainvpc.id
  map_public_ip_on_launch = "true"
  cidr_block              = "192.168.1.0/24"
  availability_zone       = "eu-north-1c"
  tags = {
    Name = "public_main"
  }
}

# Internet Gateway for accessing instances from internet
resource "aws_internet_gateway" "main_gw" {
  vpc_id = aws_vpc.mainvpc.id
  tags = {
    Name = "main"
  }
}

# route requests from any IP to internet gateway
resource "aws_route_table" "main_public_route" {
  vpc_id = aws_vpc.mainvpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main_gw.id
  }
  tags = {
    Name = "public_main_route"
  }
}

# Associate route table to subnet 
resource "aws_route_table_association" "main_public-1c" {
  subnet_id      = aws_subnet.mainvpc_public_subnet.id
  route_table_id = aws_route_table.main_public_route.id
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow Inbound SSH"
  vpc_id      = aws_vpc.mainvpc.id
  
  # allow inbound traffic to port ssh port 22
  ingress {
    description = "SSH from vpc"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # allow inbound traffic to port http port 80
  ingress {
    description = "HTTP from vpc"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # allow outbound traffic from all ports to all IPs
  egress {
    description = "outbound traffic from all ports"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
