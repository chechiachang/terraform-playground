resource "google_container_node_pool" "primary" {
  cluster        = var.gke_name
  location       = var.region
  node_locations = var.node_locations
  provider       = google-beta

  # Workaround optional block. Not for_each.
  dynamic "autoscaling" {
    for_each = var.max_node_count == null ? [] : list(1)
    content {
      max_node_count = var.max_node_count
      min_node_count = var.min_node_count
    }
  }

  management {
    auto_repair  = "true"
    auto_upgrade = var.auto_upgrade
  }

  max_pods_per_node = var.max_pods_per_node
  name              = var.node_pool_name

  node_config {
    disk_size_gb = "100"
    disk_type    = "pd-standard"
    image_type   = "COS"

    labels = var.labels

    local_ssd_count = "0"
    machine_type    = var.machine_type

    metadata = var.metadata

    oauth_scopes = [
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/servicecontrol",
      "https://www.googleapis.com/auth/trace.append",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/service.management.readonly",
    ]
    preemptible     = var.preemptible
    service_account = "default"

    shielded_instance_config {
      enable_integrity_monitoring = var.enable_integrity_monitoring
      enable_secure_boot          = "false"
    }
  }

  node_count = var.node_count
  project    = var.project
  version    = var.gke_version

  #lifecycle {
  #  prevent_destroy = true
  #}
}
