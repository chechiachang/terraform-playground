
module "ithome-demo-tw" {
  source = "../modules/compute_instance"
  providers = {
    google      = google
    google-beta = google-beta
  }

  project      = var.project
  name         = "ithome-demo-tw"
  image        = "https://www.googleapis.com/compute/v1/projects/centos-cloud/global/images/centos-7-v20200429"
  machine_type = "n1-standard-1"

  network    = "projects/${var.project}/global/networks/myproject"
  subnetwork = "projects/${var.project}/regions/asia-east1/subnetworks/myproject"

  #  metadata_startup_script = <<EOF
  #EOF

  init_disk_size = 20
  init_disk_type = "pd-standard" # Use pd-ssd for better performance

  # Additional disks
  #attached_disks = [{
  #  device_name = null # Use default device mount path: /dev/disks/ithome-demo-tw-its-cdh

  #  name  = "ithome-demo-tw-ithome-demo"
  #  type  = "pd-standard"
  #  size  = 30
  #  image = null
  #}]
}
