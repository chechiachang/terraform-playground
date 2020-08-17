
# Estimated provision time: 8m30s
# Estimated destroying time: 4m0s
module "prod-testing-k8s-tw" {
  source = "../modules/container_cluster"
  providers = {
    google      = google
    google-beta = google-beta
  }

  project    = var.project
  region     = var.region
  network    = "projects/${var.project}/global/networks/myproject"
  subnetwork = "projects/${var.project}/regions/asia-east1/subnetworks/myproject"
  #master_authorized_networks = [] # Use default value
  gke_name                 = "prod-testing-k8s-tw"
  gke_version              = "1.16.8-gke.15"
  min_master_version       = "1.16.8-gke.15" #
  remove_default_node_pool = true            # with separated node pool
  initial_node_count       = 1

  # 選擇 IP 範圍請去 google sheet 查表，拿可以用的 IP 範圍
  cluster_ipv4_cidr_block  = "10.100.32.0/20"    # Pod IP 在 VPC 裡面的私有 IP 範圍
  services_ipv4_cidr_block = "10.100.48.0/20"    # K8s service 在 VPC 裡面的私有 IP 範圍
  master_ipv4_cidr_block   = "192.168.19.240/28" # GKE 為 master 節點們保留的私有 IP 範圍
}
