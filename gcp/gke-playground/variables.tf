# Global
variable "project" {
  type    = string
  default = "gke-playground-0423"
}

variable "credential_json" {
  type    = string
  default = "../credentials/gke-playground-0423-aacf6a39cc3f.json"
}

variable "region" {
  type    = string
  default = "asia-east1"
}
