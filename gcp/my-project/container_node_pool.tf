
# Might need to apply / destroy second time to create replica after applying / destroying
# Estimated provision time: 1m
# Estimated destroying time: 4m0s
module "prod-testing-k8s-tw-application" {
  source = "../modules/container_node_pool"
  providers = {
    google      = google
    google-beta = google-beta
  }

  project        = var.project
  region         = var.region
  node_locations = null # Use cluster's node_locations: ["asia-east1-c", "asia-east1-a", "asia-east1-b"]
  gke_name       = "prod-testing-k8s-tw"

  auto_upgrade = "false" # Disable auto upgrade to prevent unexpexcted downtime

  gke_version    = "1.16.8-gke.15"
  node_pool_name = "application" # application, pool-1
  node_count     = "1"
}
