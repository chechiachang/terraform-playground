
# gcloud compute instance-templates list
resource "google_compute_instance_template" "primary" {
  can_ip_forward = "false"

  dynamic "disk" {
    for_each = var.disks
    content {
      auto_delete  = disk.value["auto_delete"]
      boot         = disk.value["boot"]
      device_name  = disk.value["device_name"]
      disk_size_gb = disk.value["disk_size_gb"]
      disk_type    = disk.value["disk_type"]
      mode         = disk.value["mode"]
      source_image = disk.value["source_image"]
      type         = disk.value["type"]
    }
  }

  enable_display = "false"

  labels = {
    container-vm = "cos-stable-81-12871-181-0"
  }

  machine_type = var.machine_type

  metadata = {
    gce-container-declaration = "spec:\n  containers:\n    - name: telegram-bot\n      image: 'chechiachang/national-team-telegram-bot:1.0.3-mia'\n      env:\n        - name: BOT_TOKEN\n          value: ''\n      stdin: false\n      tty: false\n  restartPolicy: Always\n\n# This container declaration format is not public API and may change without notice. Please\n# use gcloud command-line tool or Google Cloud Console to run Containers on Google Compute Engine."
    google-logging-enabled    = "true"
  }

  name = var.name

  network_interface {
    access_config {
      network_tier = "STANDARD"
    }

    network = var.network
  }

  project = var.project
  #region  = var.region

  scheduling {
    automatic_restart   = "false"
    on_host_maintenance = "TERMINATE"
    preemptible         = var.preemptible
  }

  service_account {
    email  = "85762449489-compute@developer.gserviceaccount.com"
    scopes = ["https://www.googleapis.com/auth/trace.append", "https://www.googleapis.com/auth/monitoring.write", "https://www.googleapis.com/auth/logging.write", "https://www.googleapis.com/auth/servicecontrol", "https://www.googleapis.com/auth/service.management.readonly", "https://www.googleapis.com/auth/devstorage.read_only"]
  }

  shielded_instance_config {
    enable_integrity_monitoring = "true"
    enable_secure_boot          = "false"
    enable_vtpm                 = "true"
  }

  lifecycle {
    ignore_changes = [
      metadata.gce-container-declaration,
      labels.container-vm,
    ]
  }
}
