output "redis" {
  value = ["${azurerm_redis_cache.standard_redis.*.hostname}"]
}
