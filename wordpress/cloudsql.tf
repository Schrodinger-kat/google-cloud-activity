resource "google_sql_database_instance" "dex" {
  name   = "wordpressdb-inst"
  region = "us-east1"
  
  settings {
    tier              = "db-f1-micro"
    availability_type = "REGIONAL"
    disk_size         = "10"

    ip_configuration {
      ipv4_enabled    = false
      private_network = google_compute_network.pokenav.self_link
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