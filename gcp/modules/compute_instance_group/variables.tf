
# Global
variable "project" {
  type = string
}

variable "region" {
  type    = string
  default = null
}

# Instance Template

variable "network" {
  type = string
}

variable "name" {
  type        = string
  description = "Name of google compute instance"
}

variable "zone" {
  type    = string
  default = "asia-east1-b"
}

variable "machine_type" {
  type    = string
  default = "n1-standard-1"
}

variable "preemptible" {
  type    = bool
  default = "true"
}

variable "disks" {
  type = list(object({
    auto_delete  = bool
    boot         = bool
    device_name  = string
    disk_size_gb = number
    disk_type    = string
    mode         = string
    source_image = string
    type         = string
  }))
  default = [{
    auto_delete  = "true"
    boot         = "true" # This is the boot disk
    device_name  = "boot"
    disk_size_gb = 10
    disk_type    = "pd-standard"
    mode         = "READ_WRITE"
    source_image = "projects/cos-cloud/global/images/cos-stable-81-12871-181-0"
    type         = "PERSISTENT"
  }]
}

# Instance Group Manager

variable "target_size" {
  type    = number
  default = 1
}

variable "update_policy" {
  type = list(object({
    max_surge_fixed         = number
    max_surge_percent       = number
    max_unavailable_fixed   = number
    max_unavailable_percent = number
    min_ready_sec           = number
    minimal_action          = string
    type                    = string
  }))
  default = [{
    max_surge_fixed         = 1
    max_surge_percent       = 0
    max_unavailable_fixed   = 1
    max_unavailable_percent = 0
    min_ready_sec           = 0
    minimal_action          = "REPLACE"
    type                    = "OPPORTUNISTIC"
  }]
}

# Autoscaler

variable "autoscaling_policy" {
  type = object({
    cooldown_period        = number
    cpu_utilization_target = number
    max_replicas           = number
    min_replicas           = number
  })
  default = {
    cooldown_period        = 60
    cpu_utilization_target = 0.6
    max_replicas           = 1
    min_replicas           = 1
  }
}
