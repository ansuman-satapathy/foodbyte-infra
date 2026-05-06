output "postgres_endpoint" {
  value = aws_db_instance.postgres.endpoint
}

output "docdb_endpoint" {
  value = aws_docdb_cluster.main.endpoint
}

output "redis_endpoint" {
  value = aws_elasticache_serverless_cache.redis.endpoint[0].address
}

output "rabbitmq_endpoint" {
  value = aws_mq_broker.rabbitmq.instances[0].endpoints[0]
}
