variable "project" {
  type = string
}

variable "region" {
  type    = string
  default = "asia-east1"
}

variable "node_locations" {
  type    = list(string)
  default = ["asia-east1-c", "asia-east1-a", "asia-east1-b"]
}

variable "network" {
  type = string
}

variable "subnetwork" {
  type = string
}

variable "gke_name" {
  type = string
}

variable "gke_version" {
  type = string
}

variable "node_version" {
  type        = string
  default     = null
  description = "if null, set node_version = gke_version"
}

variable "min_master_version" {
  type    = string
  default = null
}

#

variable "remove_default_node_pool" {
  type    = string
  default = null
}

variable "initial_node_count" {
  type = number
}

# Network

variable "ip_allocation_policy" {
  type    = bool
  default = true
}

variable "cluster_ipv4_cidr_block" {
  type    = string
  default = null
}

variable "services_ipv4_cidr_block" {
  type    = string
  default = null
}

variable "master_authorized_networks" {
  type    = list(object({ cidr_block = string, display_name = string }))
  default = null
  #default = [{
  #  display_name = "office"
  #  cidr_block   = "10.1.2.3/32"
  #  }, {
  #  display_name = "office 2"
  #  cidr_block   = "10.2.3.4/32"
  #  }, {
  #  display_name = "Cloud NAT form Internal Pod"
  #  cidr_block   = "10.3.4.5/32"
  #}]
}

variable "enable_private_endpoint" {
  type    = bool
  default = false
}

variable "enable_private_cluster" {
  type        = bool
  description = "Enable private cluster"
  default     = true
}

variable "master_ipv4_cidr_block" {
  type    = string
  default = null
}

variable "http_load_balancing_disabled" {
  type    = bool
  default = false
}


# 

variable "logging_service" {
  type        = string
  description = "Enable legacy logging"
  default     = "logging.googleapis.com/kubernetes"
}

variable "monitoring_service" {
  type        = string
  description = "Enable legacy monitoring"
  default     = "monitoring.googleapis.com/kubernetes"
}

variable "vertical_pod_autoscaling_enabled" {
  type    = bool
  default = false # beta feature
}
