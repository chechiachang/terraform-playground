
resource "google_sql_database" "primary" {
  charset   = "UTF8"
  collation = "en_US.UTF8"
  instance  = var.instance
  name      = var.name
  project   = var.project
}
