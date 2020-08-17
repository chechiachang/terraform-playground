
# Estimated provision time: 8m30s
# Estimated destroying time: 4m0s
#module "national-team-k8s-tw" {
#  source = "../modules/container_cluster"
#  providers = {
#    google      = google
#    google-beta = google-beta
#  }
#
#  project        = var.project
#  region         = "asia-east1-c" # zonal. 1 free in whole project
#  node_locations = []
#  #node_locations           = ["asia-east1-c"] # Use cluster's node_locations: ["asia-east1-c", "asia-east1-a", "asia-east1-b"]
#  network                  = "projects/${var.project}/global/networks/default"
#  subnetwork               = "projects/${var.project}/regions/asia-east1/subnetworks/default"
#  gke_name                 = "national-team-k8s-tw"
#  gke_version              = "1.16.8-gke.15"
#  min_master_version       = "1.16.8-gke.15" #
#  remove_default_node_pool = true            # with separated node pool
#  initial_node_count       = 1
#}
