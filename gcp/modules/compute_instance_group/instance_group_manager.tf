
# gcloud compute instance-groups managed list
resource "google_compute_instance_group_manager" "primary" {
  base_instance_name = var.name
  name               = var.name
  project            = var.project
  target_size        = var.target_size

  dynamic "update_policy" {
    for_each = var.update_policy
    content {
      max_surge_fixed         = update_policy.value["max_surge_fixed"]
      max_surge_percent       = update_policy.value["max_surge_fixed"] == null ? var.update_policy.value["max_surge_percent"] : null
      max_unavailable_fixed   = update_policy.value["max_unavailable_fixed"]
      max_unavailable_percent = update_policy.value["max_unavailable_fixed"] == null ? var.update_policy.value["max_unavailable_percent"] : null
      min_ready_sec           = update_policy.value["min_ready_sec"]
      minimal_action          = update_policy.value["minimal_action"]
      type                    = update_policy.value["type"]
    }
  }

  version {
    instance_template = "https://www.googleapis.com/compute/v1/projects/${var.project}/global/instanceTemplates/${var.name}"
    name              = ""
  }

  zone = var.zone
}
