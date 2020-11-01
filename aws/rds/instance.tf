resource "aws_db_instance" "mysql" {
  allocated_storage       = 20    # choose higher number for better IOPS
  storage_type            = "gp2" # general purpose storage
  engine                  = "mysql"
  engine_version          = "5.7"
  instance_class          = "db.t2.micro" # micro for free tier
  identifier              = "mysql"
  name                    = "atlas"
  username                = var.username
  password                = var.password
  parameter_group_name    = aws_db_parameter_group.mysql_default.name
  db_subnet_group_name    = aws_db_subnet_group.mysql_default.name
  multi_az                = false
  vpc_security_group_ids  = [aws_security_group.mysql_default.id]
  backup_retention_period = 30 # how long to keep those backups
  availability_zone       = aws_subnet.mysql_default.availability_zone
  tags = {
    Name = "Atlas"
  }
}