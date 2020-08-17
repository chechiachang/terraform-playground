terraform {
  backend "remote" {
    # Use terraform login to provide credential or
    # use User API Token
    #token        = ""
    hostname     = "app.terraform.io"
    organization = "chechia"

    workspaces {
      name = "aws-terraform-playground"
    }
  }
}
