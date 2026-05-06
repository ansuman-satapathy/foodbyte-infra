#######################Subnet Groups #######################
resource "aws_db_subnet_group" "rds" {
  name       = "${var.project_name}-${var.environment}-rds-group"
  subnet_ids = var.intra_subnet_ids
  tags       = { Name = "${var.project_name}-${var.environment}-rds-group" }
}

resource "aws_docdb_subnet_group" "docdb" {
  name       = "${var.project_name}-${var.environment}-docdb-group"
  subnet_ids = var.intra_subnet_ids
  tags       = { Name = "${var.project_name}-${var.environment}-docdb-group" }
}

####################### RDS PostgreSQL #######################
resource "aws_db_instance" "postgres" {
  identifier           = "${var.project_name}-${var.environment}-postgres"
  engine               = "postgres"
  engine_version       = "16.1"
  instance_class       = "db.t4g.micro"
  allocated_storage     = 20
  db_name              = "foodbyte"
  username             = "dbadmin"
  password             = var.db_password
  db_subnet_group_name = aws_db_subnet_group.rds.name
  vpc_security_group_ids = [aws_security_group.db.id]
  
  skip_final_snapshot  = true 
  storage_encrypted    = true

  tags = { Name = "${var.project_name}-${var.environment}-postgres" }
}

####################### DocumentDB #######################
resource "aws_docdb_cluster" "main" {
  cluster_identifier      = "${var.project_name}-${var.environment}-docdb"
  engine                  = "docdb"
  master_username         = "dbadmin"
  master_password         = var.db_password
  db_subnet_group_name    = aws_docdb_subnet_group.docdb.name
  vpc_security_group_ids  = [aws_security_group.db.id]
  skip_final_snapshot     = true
  storage_encrypted       = true
}

resource "aws_docdb_cluster_instance" "instance" {
  count              = 1
  identifier         = "${var.project_name}-${var.environment}-docdb-inst"
  cluster_identifier = aws_docdb_cluster.main.id
  instance_class     = "db.t3.medium"
}
