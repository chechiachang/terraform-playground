
# Estimated provision time: 4m30s 
# Estimated destroying time: 1m30s 
module "its-test-mysql-tw" {
  source = "../modules/sql"
  providers = {
    google      = google
    google-beta = google-beta
  }

  project     = var.project
  region      = var.region
  name        = "its-test-mysql-tw"
  sql_version = "MYSQL_5_7"
  tier        = "db-n1-standard-1"

  backup_configuration_start_time = "17:00" # 23:00 UTC+8, managed by DBA
  backup_configuration_location   = "asia"  # Required if master has replica

  database_flags = [{
    name  = "explicit_defaults_for_timestamp"
    value = "on"
    }, {
    name  = "log_bin_trust_function_creators"
    value = "on"
    }, {
    name  = "character_set_server"
    value = "utf8mb4"
    }, {
    name  = "event_scheduler"
    value = "on"
    }, {
    name  = "sql_mode"
    value = "NO_ENGINE_SUBSTITUTION"
    }, {
    name  = "slow_query_log"
    value = "on"
    }, {
    name  = "long_query_time"
    value = "2"
    }, {
    name  = "log_output"
    value = "FILE"
    }, {
    name  = "general_log"
    value = "on"
    }, {
    name  = "max_binlog_size"
    value = "536870912"
    }, {
    name  = "innodb_print_all_deadlocks"
    value = "on"
  }]
  ip_private_network = "projects/${var.project}/global/networks/myproject" # Private database (no public IP) only accessialbe in same vpc
  #authorized_networks = [] # Use default value

  zone = "asia-east1-b"

  maintenance_window_day  = 1
  maintenance_window_hour = 1

  # Create user when init
  username = "test_username"
}

# Might need to apply / destroy second time to create replica after applying / destroying
# Estimated provision time: 5m30s 
# Estimated destroying time: 1m30s 
module "its-test-mysql-tw-replica" {
  source = "../modules/sql"
  providers = {
    google      = google
    google-beta = google-beta
  }

  project     = var.project
  region      = var.region
  name        = "its-test-mysql-tw-replica"
  sql_version = "MYSQL_5_7"
  tier        = "db-n1-standard-1"

  master_instance_name = "its-test-mysql-tw" # Is replica

  availability_type = "ZONAL" # ZONAL replica

  binary_log_enabled              = false
  backup_configuration_enabled    = false
  backup_configuration_start_time = "17:00" # 23:00 UTC+8, managed by DBA

  database_flags = [{
    name  = "explicit_defaults_for_timestamp"
    value = "on"
    }, {
    name  = "log_bin_trust_function_creators"
    value = "on"
    }, {
    name  = "character_set_server"
    value = "utf8mb4"
    }, {
    name  = "event_scheduler"
    value = "on"
    }, {
    name  = "sql_mode"
    value = "NO_ENGINE_SUBSTITUTION"
    }, {
    name  = "slow_query_log"
    value = "on"
    }, {
    name  = "long_query_time"
    value = "2"
    }, {
    name  = "max_binlog_size"
    value = "536870912"
    }, {
    name  = "log_output"
    value = "FILE"
    }, {
    name  = "general_log"
    value = "on"
    }, {
    name  = "innodb_print_all_deadlocks"
    value = "on"
  }]

  ip_private_network = "projects/${var.project}/global/networks/myproject" # Private database (no public IP) only accessialbe in same vpc
  #authorized_networks = [] # Use default value

  pricing_plan = "PACKAGE"
  zone         = "asia-east1-a"

  maintenance_window_day  = 1
  maintenance_window_hour = 1
}
