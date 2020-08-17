
# Estimated provision time: 4m30s 
# Estimated destroying time: 1m30s 
module "its-test-postgresql-tw" {
  source = "../modules/sql"
  providers = {
    google      = google
    google-beta = google-beta
  }

  project     = var.project
  region      = var.region
  name        = "its-test-postgresql-tw"
  sql_version = "POSTGRES_11"
  tier        = "db-custom-1-3840"

  binary_log_enabled              = false
  backup_configuration_location   = "asia"  # Required if master has replica
  backup_configuration_start_time = "17:00" # 23:00 UTC+8, managed by DBA

  database_flags = [{
    name  = "log_min_duration_statement"
    value = "2000"
    }, {
    name  = "log_lock_waits"
    value = "on"
    }, {
    name  = "log_parser_stats"
    value = "on"
    }, {
    name  = "log_autovacuum_min_duration"
    value = "2000"
    }, {
    name  = "log_replication_commands"
    value = "on"
    }, {
    name  = "max_connections"
    value = "500"
    }, {
    name  = "pg_stat_statements.max"
    value = "10000"
    }, {
    name  = "pg_stat_statements.track"
    value = "all"
    }, {
    name  = "pg_stat_statements.track_utility"
    value = "off"
    }, {
    name  = "pg_stat_statements.save"
    value = "on"
    }, {
    name  = "autovacuum"
    value = "on"
    }, {
    name  = "log_statement"
    value = "all"
  }]
  ip_private_network = "projects/${var.project}/global/networks/myproject" # Private database (no public IP) only accessialbe in same vpc
  #authorized_networks = [] # Use default value

  pricing_plan = "PER_USE"
  zone         = "asia-east1-a"

  # Create user when init
  username = "test_username"
}

# Might need to apply / destroy second time to create replica after applying / destroying
# Estimated provision time: 5m30s 
# Estimated destroying time: 1m30s 
module "its-test-postgresql-tw-replica" {
  source = "../modules/sql"
  providers = {
    google      = google
    google-beta = google-beta
  }

  project     = var.project
  region      = var.region
  name        = "its-test-postgresql-tw-replica"
  sql_version = "POSTGRES_11"
  tier        = "db-custom-1-3840"

  master_instance_name = "its-test-postgresql-tw" # Is replica

  availability_type = "ZONAL" # ZONAL replica

  binary_log_enabled              = false
  backup_configuration_enabled    = false
  backup_configuration_start_time = "17:00" # 23:00 UTC+8, managed by DBA

  database_flags = [{
    name  = "log_min_duration_statement"
    value = "2000"
    }, {
    name  = "log_lock_waits"
    value = "on"
    }, {
    name  = "log_parser_stats"
    value = "on"
    }, {
    name  = "log_autovacuum_min_duration"
    value = "2000"
    }, {
    name  = "log_replication_commands"
    value = "on"
    }, {
    name  = "max_connections"
    value = "500"
    }, {
    name  = "pg_stat_statements.max"
    value = "10000"
    }, {
    name  = "pg_stat_statements.track"
    value = "all"
    }, {
    name  = "pg_stat_statements.track_utility"
    value = "off"
    }, {
    name  = "pg_stat_statements.save"
    value = "on"
    }, {
    name  = "autovacuum"
    value = "on"
    }, {
    name  = "log_statement"
    value = "all"
  }]
  ip_private_network = "projects/${var.project}/global/networks/myproject" # Private database (no public IP) only accessialbe in same vpc
  ipv4_enabled       = false
  #authorized_networks = [] # Use default value

  pricing_plan = "PACKAGE"
  zone         = "asia-east1-b"
}
