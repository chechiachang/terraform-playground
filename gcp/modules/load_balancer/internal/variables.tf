
variable "project" {
  type = string
}

variable "region" {
  type    = string
  default = "asia-east1"
}

# Load Balancer

variable "backend_service_name" {
  type = string
}

variable "network" {
  type = string
}

variable "subnetwork" {
  type = string
}

variable "ip_address" {
  type = string
}

variable "protocol" {
  type    = string
  default = "TCP"
}

variable "load_balancing_scheme" {
  type    = string
  default = "INTERNAL"
}

variable "forwarding_rule_name" {
  type = string
}

variable "all_ports" {
  type    = bool
  default = false
}

variable "allow_global_access" {
  type    = bool
  default = false
}

variable "ports" {
  type    = list(string)
  default = null
}

variable "health_check_name" {
  type = string
}

variable "tcp_health_checks" {
  type = list(object({
    port         = number,
    proxy_header = string,
  }))
  default = null
}

variable "backends" {
  type = list(object({
    balancing_mode = string,
    group          = string,
  }))
  default = null
}

variable "service_label" {
  type    = string
  default = null
}
