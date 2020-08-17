
resource "aws_vpc" "default" { # vpc-c8fde9af
  cidr_block       = "172.31.0.0/16"
  instance_tenancy = "default"
  tags = {
    Name = "default"
  }
}

resource "aws_vpc_dhcp_options" "default" { # dopt-75a59712
  domain_name         = "ap-northeast-1.compute.internal"
  domain_name_servers = ["AmazonProvidedDNS"]
  tags = {
    Name = "default"
  }
}

resource "aws_vpc_dhcp_options_association" "default_default" { # vpc-c8fde9af-dopt-75a59712
  vpc_id          = aws_vpc.default.id
  dhcp_options_id = aws_vpc_dhcp_options.default.id
}

resource "aws_subnet" "default-c" { # subnet-226b6879
  vpc_id                  = aws_vpc.default.id
  cidr_block              = "172.31.0.0/20"
  availability_zone       = "ap-northeast-1c"
  map_public_ip_on_launch = true
  tags = {
    Name = "default"
  }
}

resource "aws_subnet" "default-a" {
  vpc_id                  = aws_vpc.default.id
  cidr_block              = "172.31.32.0/20"
  availability_zone       = "ap-northeast-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "default"
  }
}

resource "aws_subnet" "default-d" {
  vpc_id                  = aws_vpc.default.id
  cidr_block              = "172.31.16.0/20"
  availability_zone       = "ap-northeast-1d"
  map_public_ip_on_launch = true
  tags = {
    Name = "default"
  }
}
