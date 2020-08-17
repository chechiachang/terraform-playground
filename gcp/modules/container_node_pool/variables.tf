variable "project" {
  type = string
}

variable "region" {
  type    = string
  default = "asia-east1"
}

variable "node_locations" {
  type    = list(string)
  default = null # Use cluster's node_location
}

variable "gke_name" {
  type = string
}

variable "gke_version" {
  type = string
}

variable "max_pods_per_node" {
  type    = string
  default = null
}

variable "max_node_count" {
  type    = number
  default = null
}

variable "min_node_count" {
  type    = number
  default = null
}

variable "auto_upgrade" {
  type = string
}

variable "node_pool_name" {
  type = string
}

variable "machine_type" {
  type    = string
  default = "n1-standard-1"
}

variable "preemptible" {
  type    = bool
  default = false
}

variable "enable_integrity_monitoring" {
  type    = bool
  default = true
}

variable "node_count" {
  type    = number
  default = 1
}

variable "labels" {
  type    = map
  default = null
}

variable "metadata" {
  type = map
  default = {
    disable-legacy-endpoints = "true"
  }
}
