# 1. Subnet Groups
resource "aws_db_subnet_group" "rds" {
  name       = "${var.project_name}-${var.environment}-rds-group"
  subnet_ids = var.intra_subnet_ids
  tags       = { Name = "${var.project_name}-${var.environment}-rds-group" }
}

# 2. RDS PostgreSQL for User Service
resource "aws_db_instance" "user_db" {
  identifier           = "${var.project_name}-${var.environment}-user-db"
  engine               = "postgres"
  engine_version       = "18.3"
  instance_class       = "db.t4g.micro"
  allocated_storage     = 20
  db_name              = "users_db"
  username             = "dbadmin"
  password             = var.db_password
  db_subnet_group_name = aws_db_subnet_group.rds.name
  vpc_security_group_ids = [aws_security_group.db.id]
  skip_final_snapshot  = true
  storage_encrypted    = true
  tags = { Name = "${var.project_name}-${var.environment}-user-db" }
}

# 3. RDS PostgreSQL for Order Service
resource "aws_db_instance" "order_db" {
  identifier           = "${var.project_name}-${var.environment}-order-db"
  engine               = "postgres"
  engine_version       = "18.3"
  instance_class       = "db.t4g.micro"
  allocated_storage     = 20
  db_name              = "orders_db"
  username             = "dbadmin"
  password             = var.db_password
  db_subnet_group_name = aws_db_subnet_group.rds.name
  vpc_security_group_ids = [aws_security_group.db.id]
  skip_final_snapshot  = true
  storage_encrypted    = true
  tags = { Name = "${var.project_name}-${var.environment}-order-db" }
}
