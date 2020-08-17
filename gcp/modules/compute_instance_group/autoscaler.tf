
# gcloud compute instance-groups managed describe
resource "google_compute_autoscaler" "primary" {
  autoscaling_policy {
    cooldown_period = var.autoscaling_policy.cooldown_period
    cpu_utilization {
      target = var.autoscaling_policy.cpu_utilization_target

    }
    max_replicas = var.autoscaling_policy.max_replicas
    min_replicas = var.autoscaling_policy.min_replicas
  }

  name    = var.name
  project = var.project
  target  = "https://www.googleapis.com/compute/v1/projects/${var.project}/zones/${var.zone}/instanceGroupManagers/${var.name}"
  zone    = "https://www.googleapis.com/compute/v1/projects/${var.project}/zones/${var.zone}"
}
