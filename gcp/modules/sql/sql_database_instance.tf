resource "google_sql_database_instance" "primary" {
  database_version = var.sql_version
  name             = var.name
  project          = var.project
  region           = var.region

  master_instance_name = var.master_instance_name
  dynamic "replica_configuration" {
    for_each = var.master_instance_name == null ? [] : list(1)
    content {
      connect_retry_interval    = "0"
      failover_target           = var.failover_target
      master_heartbeat_period   = "0"
      verify_server_certificate = "false"
    }
  }

  settings {
    activation_policy = var.activation_policy
    availability_type = var.availability_type

    backup_configuration {
      binary_log_enabled = var.binary_log_enabled
      enabled            = var.backup_configuration_enabled
      location           = var.backup_configuration_location
      start_time         = var.backup_configuration_start_time
    }

    disk_autoresize = "true"
    disk_size       = var.disk_size
    disk_type       = "PD_SSD"

    dynamic "database_flags" {
      for_each = var.database_flags
      content {
        name  = database_flags.value["name"]
        value = database_flags.value["value"]
      }
    }

    ip_configuration {

      dynamic "authorized_networks" {
        for_each = var.authorized_networks
        content {
          name  = authorized_networks.value["name"]
          value = authorized_networks.value["value"]
        }
      }

      ipv4_enabled    = var.ipv4_enabled
      private_network = var.ip_private_network
      require_ssl     = "false"
    }

    location_preference {
      zone = var.zone
    }

    dynamic "maintenance_window" {
      for_each = var.maintenance_window_day == null ? [] : list(1)
      content {
        day          = var.maintenance_window_day
        hour         = var.maintenance_window_hour
        update_track = var.maintenance_window_update_track
      }
    }

    pricing_plan = var.pricing_plan
    tier         = var.tier
  }

  lifecycle {
    ignore_changes = [
      settings[0].maintenance_window,                      # FIXME maintenance_window_day = any still not supported
      settings[0].ip_configuration[0].authorized_networks, # FIXME failed to keep order
      settings[0].database_flags                           # Managed by DBA. Out of scope
    ]
  }
}
