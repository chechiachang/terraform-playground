# Global
variable "project" {
  type    = string
  default = "myproject"
}

variable "shared_credentials_file" {
  type    = string
  default = "../credentials/credentials"
}

variable "region" {
  type    = string
  default = "ap-northeast-1"
}
