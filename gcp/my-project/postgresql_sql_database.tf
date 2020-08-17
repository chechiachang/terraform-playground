
module "prod-testing-postgresql-tw-silkrode_testing" {
  source = "../modules/sql/postgresql"
  providers = {
    google      = google
    google-beta = google-beta
  }

  instance = "prod-testing-postgresql-tw"
  name     = "silkrode_testing"
  project  = var.project
}
