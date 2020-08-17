
module "its-test-postgresql-tw-test_database" {
  source = "../modules/sql/postgresql"
  providers = {
    google      = google
    google-beta = google-beta
  }

  instance = "its-test-postgresql-tw"
  name     = "test_database"
  project  = var.project
}
