# Configure the AWS Provider
provider "aws" {
  version                 = "~> 2.0"
  shared_credentials_file = file(var.shared_credentials_file)
  region                  = "ap-northeast-1"
}

# Create a VPC
#resource "aws_vpc" "example" {
#  cidr_block = "10.0.0.0/16"
#}
