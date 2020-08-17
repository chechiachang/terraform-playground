resource "google_container_cluster" "primary" {
  addons_config {
    horizontal_pod_autoscaling {
      disabled = "false"
    }

    http_load_balancing {
      disabled = var.http_load_balancing_disabled
    }

    network_policy_config {
      disabled = "true"
    }
  }

  cluster_autoscaling {
    enabled = "false"
  }

  min_master_version = var.min_master_version
  # cluster_ipv4_cidr         = "10.12.0.0/14" # Let GCP decide cidr
  default_max_pods_per_node = "110"
  enable_kubernetes_alpha   = "false"
  enable_legacy_abac        = "false"
  remove_default_node_pool  = var.remove_default_node_pool # with separated node pool
  initial_node_count        = var.initial_node_count

  dynamic "ip_allocation_policy" {
    for_each = var.ip_allocation_policy == true ? list(1) : []
    content {
      cluster_ipv4_cidr_block  = var.cluster_ipv4_cidr_block
      services_ipv4_cidr_block = var.services_ipv4_cidr_block
    }
  }

  location        = var.region # regional
  logging_service = var.logging_service

  master_auth {
    # username = ""
    # password = ""

    client_certificate_config {
      issue_client_certificate = "false"
    }
  }

  dynamic "master_authorized_networks_config" {
    for_each = var.master_authorized_networks == null ? [] : list(1)
    content {
      dynamic "cidr_blocks" {
        for_each = var.master_authorized_networks
        content {
          cidr_block   = cidr_blocks.value["cidr_block"]
          display_name = cidr_blocks.value["display_name"]
        }
      }
    }
  }

  monitoring_service = var.monitoring_service
  name               = var.gke_name
  network            = var.network

  network_policy {
    enabled = "false"
  }

  node_locations = var.node_locations
  node_version   = var.node_version != null ? var.node_version : var.gke_version

  dynamic "private_cluster_config" {
    for_each = var.enable_private_cluster ? list(1) : []
    content {
      enable_private_endpoint = var.enable_private_endpoint
      enable_private_nodes    = var.master_ipv4_cidr_block != null ? true : false
      master_ipv4_cidr_block  = var.master_ipv4_cidr_block
    }
  }

  project    = var.project
  subnetwork = var.subnetwork

  dynamic "vertical_pod_autoscaling" {
    for_each = var.vertical_pod_autoscaling_enabled == true ? list(1) : []
    content {
      enabled = var.vertical_pod_autoscaling_enabled
    }
  }

  #lifecycle {
  #  prevent_destroy = true
  #}
}
