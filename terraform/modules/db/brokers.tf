####################### ElastiCache Redis #######################
resource "aws_elasticache_subnet_group" "redis" {
  name       = "${var.project_name}-${var.environment}-redis-group"
  subnet_ids = var.intra_subnet_ids
}

resource "aws_elasticache_serverless_cache" "redis" {
  name       = "${var.project_name}-${var.environment}-redis"
  engine     = "redis"
  
  description = "FoodByte Notification Cache"
  
  subnet_ids         = var.intra_subnet_ids
  security_group_ids = [aws_security_group.db.id]
}

#######################Amazon MQ RabbitMQ #######################
resource "aws_mq_broker" "rabbitmq" {
  broker_name = "${var.project_name}-${var.environment}-mq"

  engine_type        = "RabbitMQ"
  engine_version     = "3.13"
  host_instance_type = "mq.t3.micro" 
  
  subnet_ids = [var.intra_subnet_ids[0]]
  
  security_groups = [aws_security_group.db.id]
  deployment_mode = "SINGLE_INSTANCE"

  user {
    username = "mqadmin"
    password = var.db_password
  }

  publicly_accessible = false
}
