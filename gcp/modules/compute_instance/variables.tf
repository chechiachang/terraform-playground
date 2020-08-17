# Global
variable "project" {
  type = string
}

variable "region" {
  type    = string
  default = "asia-east1"
}

# GCE
variable "image" {
  type    = string
  default = "https://www.googleapis.com/compute/v1/projects/centos-cloud/global/images/centos-7-v20200429"
}

variable "access_config_enabled" {
  type    = bool
  default = false # Default has no external IP
}

variable "nat_ip" {
  type    = string
  default = null # Default use peripheral ip
}

variable "network" {
  type = string
}

variable "network_ip" {
  type    = string
  default = null # Let gcp decide private ip
}

variable "subnetwork" {
  type = string
}

variable "name" {
  type        = string
  description = "Name of google compute instance"
}

variable "description" {
  type    = string
  default = null
}

variable "zone" {
  type    = string
  default = "asia-east1-b"
}

variable "machine_type" {
  type    = string
  default = "n1-standard-1"
}

# Disk

variable "init_disk_size" {
  type    = number
  default = 20
}

variable "init_disk_type" {
  type    = string
  default = "pd-standard"
}

variable "attached_disks" {
  type = list(object({
    device_name = string,
    name        = string,
    type        = string,
    size        = number,
    image       = string
  }))
  default = []
}


variable "metadata_startup_script" {
  type    = string
  default = null
}
