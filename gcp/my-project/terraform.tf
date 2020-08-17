terraform {
  # Create a remote organization on https://app.terraform.io
  backend "remote" {
    # Provide terraform credential by
    # - terraform login (suggested)
    # - use User API Token
    #token        = ""
    hostname     = "app.terraform.io"
    organization = "chechia"

    workspaces {
      name = "terraform-playground"
    }
  }
}
