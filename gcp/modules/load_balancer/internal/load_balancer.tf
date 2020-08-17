
resource "google_compute_forwarding_rule" "primary" {
  all_ports             = var.all_ports
  allow_global_access   = var.allow_global_access
  ports                 = var.ports
  backend_service       = "https://www.googleapis.com/compute/v1/projects/${var.project}/regions/asia-east1/backendServices/${var.backend_service_name}"
  ip_address            = var.ip_address
  ip_protocol           = "TCP"
  load_balancing_scheme = var.load_balancing_scheme
  name                  = var.forwarding_rule_name
  network               = var.network
  subnetwork            = var.subnetwork
  service_label         = var.service_label
  network_tier          = "PREMIUM"
  project               = var.project
  region                = var.region
}

resource "google_compute_region_backend_service" "primary" {
  affinity_cookie_ttl_sec = "0"

  dynamic "backend" {
    for_each = var.backends
    content {
      balancing_mode               = backend.value["balancing_mode"]
      capacity_scaler              = "0"
      failover                     = "false"
      group                        = backend.value["group"]
      max_connections              = "0"
      max_connections_per_endpoint = "0"
      max_connections_per_instance = "0"
      max_rate                     = "0"
      max_rate_per_endpoint        = "0"
      max_rate_per_instance        = "0"
      max_utilization              = "0"
    }
  }

  connection_draining_timeout_sec = "300"
  health_checks                   = ["projects/${var.project}/global/healthChecks/${var.health_check_name}"]
  load_balancing_scheme           = var.load_balancing_scheme
  name                            = var.backend_service_name
  project                         = var.project
  protocol                        = var.protocol
  region                          = var.region
  session_affinity                = "NONE"
  timeout_sec                     = "30"
}

resource "google_compute_health_check" "primary" {
  check_interval_sec = "10"
  healthy_threshold  = "2"
  name               = var.health_check_name
  project            = var.project

  dynamic "tcp_health_check" {
    for_each = var.tcp_health_checks
    content {
      port         = tcp_health_check.value["port"]
      proxy_header = tcp_health_check.value["proxy_header"]
    }
  }

  timeout_sec         = "5"
  unhealthy_threshold = "3"
}
