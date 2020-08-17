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

variable "sql_version" {
  type        = string
  description = "MYSQL_5_7 or POSTGRES_11"
}

variable "tier" {
  type    = string
  default = "db-n1-standard-1"
}

# User

variable "username" {
  type        = string
  description = "name of user to create when init database"
  default     = null # Default don't create sql_user when init database
}

# Replica
variable "master_instance_name" {
  type        = string
  default     = null
  description = "null if is master itself. valued if is replica"
}

variable "failover_target" {
  type        = string
  default     = false
  description = "true if is failover instance"
}
# Setting
variable "activation_policy" {
  type    = string
  default = "ALWAYS"
}

variable "availability_type" {
  type    = string
  default = "REGIONAL" # Our default is REGIONAL
}

variable "database_flags" {
  type        = list(object({ name = string, value = string }))
  description = "No default. Let DBA handle"
  default     = []
}

variable "ip_private_network" {
  type    = string
  default = "projects/myproject/global/networks/myproject"
}

variable "binary_log_enabled" {
  type    = bool
  default = true # enabled to use GCP Second-generation instance
}

variable "backup_configuration_enabled" {
  type    = bool
  default = true # enabled to use GCP Second-generation instance
}

variable "backup_configuration_location" {
  type    = string
  default = null
}

variable "backup_configuration_start_time" {
  type    = string
  default = "1:00" # 9:00 UTC+8 - working hour
}

variable "disk_size" {
  type    = number
  default = 10
}

variable "authorized_networks" {
  type = list(object({ name = string, value = string }))
  default = [{
    name  = "office"
    value = "10.1.2.3/32"
    }, {
    name  = "office 2"
    value = "10.2.3.4/32"
    }, {
    name  = "Cloud NAT form Internal Pod"
    value = "10.3.4.5/32"
  }]
}

variable "ipv4_enabled" {
  type    = bool
  default = false # Enforece private endpoint by disabling public ipv4
}

variable "pricing_plan" {
  type        = string
  default     = "PER_USE"
  description = "master: PER_USE / replica:PACKAGE"
}

variable "zone" {
  type = string
}

variable "maintenance_window_day" {
  type    = string
  default = 1 # Monday
}

variable "maintenance_window_hour" {
  type    = string
  default = 1 # 9:00 UTC+8 - working hour
}

variable "maintenance_window_update_track" {
  type        = string
  description = "canary | stable"
  default     = null
}
