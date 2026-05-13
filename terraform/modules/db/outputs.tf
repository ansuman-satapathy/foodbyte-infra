output "user_postgres_endpoint" {
  value       = aws_db_instance.user_db.endpoint
  description = "Endpoint for the User Service database"
}

output "order_postgres_endpoint" {
  value       = aws_db_instance.order_db.endpoint
  description = "Endpoint for the Order Service database"
}

output "docdb_endpoint" {
  value       = aws_docdb_cluster.main.endpoint
  description = "Endpoint for the Restaurant Service DocumentDB"
}

output "redis_endpoint" {
  value       = aws_elasticache_serverless_cache.redis.endpoint[0].address
  description = "Endpoint for the Notification Service Redis"
}

output "rabbitmq_endpoint" {
  value       = aws_mq_broker.rabbitmq.instances[0].endpoints[0]
  description = "Endpoint for the RabbitMQ broker"
}
