
resource "google_service_account" "its-test-chechia-net-tw" {
  account_id   = "its-test-chechia-net-tw"
  display_name = "its-test-chechia-net-tw"
  project      = var.project
}
