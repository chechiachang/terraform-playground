provider "google" {
  version = "~>v3.25.0"

  credentials = file(var.credential_json)

  project = var.project
  region  = var.region
}

# Beta feature
provider "google-beta" {
  version = "~>3.19.0"

  credentials = file(var.credential_json)

  project = var.project
  region  = var.region
}
