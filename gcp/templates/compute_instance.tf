
module "its-test-tw" {
  source = "../modules/compute_instance"
  providers = {
    google      = google
    google-beta = google-beta
  }

  project      = var.project
  name         = "its-test-tw"
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
  #  device_name = null # Use default device mount path: /dev/disks/its-test-tw-its-cdh

  #  name  = "its-test-tw-its-test"
  #  type  = "pd-standard"
  #  size  = 30
  #  image = null
  #}]
}
