
# Global
variable "location" {
  type    = string
  default = "Japan East"
}

variable "resource_group_name" {
  type    = string
  default = "default"
}

# VM
variable "name" {
  type = string
}

variable "vm_size" {
  type    = string
  default = "Standard_B1ls" # 1 vcpu, 0.5 Gi Memory = $0.0075/hour
}

variable "subnet_id" {
  type = string
}

variable "storage_image_reference_publisher" {
  type    = string
  default = "Canonical"
}

variable "storage_image_reference_offer" {
  type    = string
  default = "UbuntuServer"
}

variable "storage_image_reference_sku" {
  type    = string
  default = "18.04-LTS"
}

variable "storage_image_reference_version" {
  type    = string
  default = "latest"
}

variable "username" {
  type    = string
  default = null
}
