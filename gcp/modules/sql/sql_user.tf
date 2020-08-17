
resource "random_password" "password" {
  count = var.username != null ? 1 : 0 # count = 0 if var.username is null

  length           = 32
  special          = true
  override_special = "!@$%&*"
}

resource "google_sql_user" "user" {
  count = var.username != null ? 1 : 0 # count = 0 if var.username is null

  name     = var.username
  instance = var.name
  host     = var.sql_version == "MYSQL_5_7" ? "%" : null # provider host if is mysql
  password = random_password.password[0].result

  lifecycle {
    ignore_changes = [
      password # Managed by DBA. Out of scope. DANGER! Never overwrite existing remote password.
    ]
  }
}
