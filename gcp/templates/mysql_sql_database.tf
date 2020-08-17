
module "its-test-mysql-tw-test_database" {
  source = "../modules/sql/mysql"
  providers = {
    google      = google
    google-beta = google-beta
  }

  instance = "its-test-mysql-tw"
  name     = "test_database"
  project  = var.project
}
