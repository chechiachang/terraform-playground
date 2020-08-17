
resource "google_compute_forwarding_rule" "primary" {
  all_ports           = var.all_ports
  allow_global_access = var.allow_global_access
  ip_address          = var.ip_address
  ip_protocol         = "TCP"
  name                = var.forwarding_rule_name
  network_tier        = "PREMIUM"
  project             = var.project
  region              = var.region

  load_balancing_scheme = var.load_balancing_scheme
  port_range            = var.port_range
  target                = var.target
}

resource "google_compute_target_pool" "nginx-ha" {
  failover_ratio   = "0"
  description      = var.description
  health_checks    = var.target_pool_health_checks
  instances        = var.target_pool_instances
  name             = var.target_pool_name
  project          = var.project
  region           = var.region
  session_affinity = "NONE"
}
