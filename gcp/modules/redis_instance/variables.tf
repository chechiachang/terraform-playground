variable "project" {
  type = string
}

variable "region" {
  type    = string
  default = "asia-east1"
}

variable "name" {
  type = string
}

# Redis

variable "display_name" {
  type    = string
  default = null # Use self.name
}

variable "alternative_location_id" {
  type    = string
  default = null
}

variable "authorized_network" {
  type = string
}

variable "reserved_ip_range" {
  type    = string
  default = null # Let gcp decide
}

variable "location_id" {
  type = string
}

variable "memory_size_gb" {
  type    = number
  default = 1
}

variable "redis_version" {
  type    = string
  default = "REDIS_4_0"
}

variable "tier" {
  type    = string
  default = "STANDARD_HA"
}

