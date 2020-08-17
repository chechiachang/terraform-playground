
resource "google_storage_bucket" "testing" {
  bucket_policy_only = "false"

  #cors {
  #  max_age_seconds = "3600"
  #  method          = ["GET", "HEAD", "DELETE"]
  #  origin          = ["*"]
  #  response_header = ["Content-Type"]
  #}

  force_destroy = "false"

  #lifecycle_rule {
  #  action {
  #    type = "Delete"
  #  }

  #  condition {
  #    age                = "15"
  #    created_before     = ""
  #    is_live            = "false"
  #    num_newer_versions = "0"
  #    with_state         = "ANY"
  #  }
  #}

  location       = "ASIA-EAST1" # ASIA-EAST1 / US
  name           = "testing"
  project        = var.project
  requester_pays = "false"
  storage_class  = "STANDARD" # STANDARD / REGIONAL

  #website {
  #  main_page_suffix = "index.html"
  #  not_found_page   = "index.html"
  #}

  #versioning {
  #  enabled = "true"
  #}
}
