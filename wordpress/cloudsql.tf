resource "google_sql_database_instance" "dex" {
  name   = "wordpressdb_inst"
  
  settings {
    tier              = "db-f1-micro"
    availability_type = "REGIONAL"
    disk_size         = "10"

    ip_configuration {
      ipv4_enabled    = false        # don't give the db a public IPv4
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

/*

resource "google_sql_database" "main" {
  name     = "wordpressdb"
  instance = google_sql_database_instance.Apokedex.name
}

resource "google_sql_database_instance" "Apokedex" {
  name             = "wordpress"
  database_version = "MYSQL"
  depends_on       = [var.db_depends_on]

  settings {
    tier              = "db-f1-micro"
    availability_type = "REGIONAL"
    disk_size         = "10"

    ip_configuration {
      ipv4_enabled    = false        # don't give the db a public IPv4
      private_network = google_compute_network.Apokenav.self_link # the VPC where the db will be assigned a private IP
    }
  }
}

resource "google_sql_user" "db_user" {
  name     = "jishnn"
  instance = google_sql_database_instance.Apokedex.name
  password = var.password
}
*/