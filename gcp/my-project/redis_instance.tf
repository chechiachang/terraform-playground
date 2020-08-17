
# Estimated provision time: 4m10s
# Estimated destroying time: 2m00s
module "prod-testing-redis-tw" {
  source = "../modules/redis_instance"
  providers = {
    google = google
  }
  project                 = var.project
  region                  = var.region
  name                    = "prod-testing-redis-tw"
  location_id             = "asia-east1-a"
  alternative_location_id = "asia-east1-b"
  authorized_network      = "projects/${var.project}/global/networks/myproject" # Only accessialbe in same vpc
  reserved_ip_range       = "10.142.10.112/29"                                  # check gcp/README.md to get valid cidr
}
