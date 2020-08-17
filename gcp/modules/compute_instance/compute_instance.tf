resource "google_compute_instance" "primary" {
  boot_disk {
    auto_delete = "true"
    device_name = var.name

    initialize_params {
      image = var.image
      size  = var.init_disk_size
      type  = var.init_disk_type
    }

    mode = "READ_WRITE"
    #source = "https://www.googleapis.com/compute/v1/projects/${var.project}/zones/asia-east1-b/disks/${var.name}"
  }

  can_ip_forward      = "false"
  deletion_protection = "false"
  enable_display      = "false"
  machine_type        = var.machine_type
  name                = var.name
  description         = var.description

  network_interface {
    dynamic "access_config" {
      for_each = var.access_config_enabled == true ? list(1) : []
      content {
        nat_ip = var.nat_ip
        # network_tier = "PREMIUM" # Default: PREMIUM
      }
    }

    network            = var.network
    network_ip         = var.network_ip
    subnetwork         = var.subnetwork
    subnetwork_project = var.project
  }

  metadata_startup_script = var.metadata_startup_script

  project = var.project

  scheduling {
    automatic_restart   = "true"
    on_host_maintenance = "MIGRATE"
    preemptible         = "false"
  }

  service_account {
    #email = "642929215281-compute@developer.gserviceaccount.com" # Use default gcp compute service account
    scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/servicecontrol",
      "https://www.googleapis.com/auth/trace.append",
      "https://www.googleapis.com/auth/service.management.readonly",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/monitoring.write"
    ]
  }

  shielded_instance_config {
    enable_integrity_monitoring = "true"
    enable_secure_boot          = "false"
    enable_vtpm                 = "true"
  }

  zone = var.zone

  dynamic "attached_disk" {
    for_each = var.attached_disks
    content {
      source      = attached_disk.value["name"] # Use name of created disk as source
      device_name = attached_disk.value["device_name"]
    }
  }

  lifecycle {
    ignore_changes = [
      metadata_startup_script
    ]
  }
}

resource "google_compute_disk" "primary" {
  count                     = length(var.attached_disks)
  name                      = var.attached_disks[count.index].name
  type                      = var.attached_disks[count.index].type
  zone                      = var.zone
  size                      = var.attached_disks[count.index].size
  image                     = var.attached_disks[count.index].image
  physical_block_size_bytes = 4096
}
