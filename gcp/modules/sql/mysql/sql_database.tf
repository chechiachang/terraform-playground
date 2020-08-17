
resource "google_sql_database" "primary" {
  charset   = "utf8mb4"
  collation = "utf8mb4_general_ci"
  instance  = var.instance
  name      = var.name
  project   = var.project
}
