resource "aws_db_parameter_group" "mysql_default" {
  name   = "mysql"
  family = "mysql5.7"

  parameter {
    name  = "max_allowed_packets"
    value = "1000000000" # 1GB
  }
}

resource "aws_db_subnet_group" "mysql_default" {
  name       = "mysql_default"
  subnet_ids = [aws_subnet.mysql_default.id]
  tags = {
    Name = "mysql_default"
  }
}