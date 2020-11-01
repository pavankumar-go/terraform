resource "aws_vpc" "mysql_default" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "db_vpc"
  }
}


resource "aws_subnet" "mysql_default" {
  cidr_block              = "10.0.1.0/24"
  vpc_id                  = aws_vpc.mysql_default.id
  availability_zone       = var.db_availability_zone
  map_public_ip_on_launch = false
  tags = {
    Name = "db_subnet"
  }
}