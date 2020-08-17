
module "its-test-tw" {
  source = "../modules/compute_instance_group"
  providers = {
    google      = google
    google-beta = google-beta
  }

  project      = var.project
  name         = "its-test-tw"
  machine_type = "n1-standard-1"

  network    = "projects/${var.project}/global/networks/default"
  subnetwork = "projects/${var.project}/regions/asia-east1/subnetworks/myproject"

  #  metadata_startup_script = <<EOF
  #EOF

  source_image   = "projects/cos-cloud/global/images/cos-stable-81-12871-181-0"
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
