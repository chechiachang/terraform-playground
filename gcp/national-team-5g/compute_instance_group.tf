
# terraform import module.telegram-bot.google_compute_instance_template.primary national-team-5g/asia-east1-b/telegram-bot
# terraform import module.telegram-bot.google_compute_instance_group_manager.primary national-team-5g/asia-east1-b/telegram-bot
# terraform import module.telegram-bot.google_compute_autoscaler.primary national-team-5g/asia-east1-b/telegram-bot
module "telegram-bot" {
  source = "../modules/compute_instance_group"
  providers = {
    google      = google
    google-beta = google-beta
  }

  project      = var.project
  name         = "telegram-bot"
  machine_type = "g1-small"

  network = "projects/${var.project}/global/networks/default"
  #subnetwork = "projects/${var.project}/regions/asia-east1/subnetworks/myproject"

  #  metadata_startup_script = <<EOF
  #EOF

  disks = [{
    auto_delete  = "true"
    boot         = "true"
    device_name  = "telegram-bot"
    disk_size_gb = 10
    disk_type    = "pd-standard"
    mode         = "READ_WRITE"
    source_image = "projects/cos-cloud/global/images/cos-stable-81-12871-181-0"
    type         = "PERSISTENT"
  }]

  # Instance Group Manager
  update_policy = [{
    max_surge_fixed         = 1 # Set null to use persent
    max_surge_percent       = 0
    max_unavailable_fixed   = 1 # set null to use percent
    max_unavailable_percent = 0
    min_ready_sec           = 0
    minimal_action          = "REPLACE"
    type                    = "OPPORTUNISTIC"
  }]

  # Autoscaler
  autoscaling_policy = {
    cooldown_period        = 60
    cpu_utilization_target = 0.6
    max_replicas           = 1
    min_replicas           = 1
  }
}
