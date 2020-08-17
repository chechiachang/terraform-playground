resource "google_redis_instance" "primary" {
  alternative_location_id = var.alternative_location_id
  authorized_network      = var.authorized_network
  display_name            = var.display_name == null ? var.name : var.display_name
  location_id             = var.location_id
  memory_size_gb          = var.memory_size_gb
  name                    = var.name
  project                 = var.project
  redis_version           = var.redis_version
  region                  = var.region
  reserved_ip_range       = var.reserved_ip_range
  tier                    = var.tier
}
