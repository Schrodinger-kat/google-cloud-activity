resource "google_sql_database_instance" "dex" {
  name   = "wordpressdb-inst"
  database_version = "MYSQL_5_6"
  
  settings {
    tier              = "db-f1-micro"
    availability_type = "REGIONAL"
    disk_size         = "10"

    backup_configuration {
      binary_log_enabled = true
      enabled = true
    }
    ip_configuration {
      ipv4_enabled    = true
      //private_network = google_compute_network.pokenav.self_link
  }

}

  deletion_protection  = "false"
}

resource "google_sql_database" "dexpss" {
  name     = "wordpressdb"
  instance = google_sql_database_instance.dex.self_link
}

resource "random_id" "db_name_suffix" {
  byte_length = 4
}

resource "google_sql_user" "users" {
  name     = "admin"
  instance = google_sql_database_instance.dex.self_link
  host     = "wordpress.com"
  password = "324b21"
}