
module "prod-testing-mysql-tw-silkrode_testing" {
  source = "../modules/sql/mysql"
  providers = {
    google      = google
    google-beta = google-beta
  }

  instance = "prod-testing-mysql-tw"
  name     = "silkrode_testing"
  project  = var.project
}
