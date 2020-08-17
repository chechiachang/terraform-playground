
variable "project" {
  type = string
}

variable "region" {
  type    = string
  default = "asia-east1"
}

# Load Balancer

variable "ip_address" {
  type = string
}

variable "protocol" {
  type    = string
  default = "TCP"
}

variable "load_balancing_scheme" {
  type    = string
  default = "EXTERNAL"
}

variable "forwarding_rule_name" {
  type = string
}

variable "description" {
  type    = string
  default = null
}

variable "all_ports" {
  type    = bool
  default = false
}

variable "allow_global_access" {
  type    = bool
  default = false
}

variable "port_range" {
  type = string
}

variable "target_pool_health_checks" {
  type    = list(string)
  default = null
}

variable "target_pool_name" {
  type = string
}

variable "target" {
  type = string
}

variable "target_pool_instances" {
  type = list(string)
}
