resource "aws_db_instance" "app_db" {
  allocated_storage    = 20
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  name                 = "appdb"
  username             = var.db_username
  password             = var.db_password
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true
  publicly_accessible  = false
  vpc_security_group_ids = [var.rds_sg_id]
  db_subnet_group_name = aws_db_subnet_group.db_subnet.id
}

resource "aws_db_subnet_group" "db_subnet" {
  name       = "db-subnet"
  subnet_ids = var.private_subnet_ids
}
