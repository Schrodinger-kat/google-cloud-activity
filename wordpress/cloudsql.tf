resource "google_sql_database" "pss" {
  name     = "wordpress-db"
  instance = google_sql_database_instance.pokedex.name
}

resource "google_sql_database_instance" "pokedex" {
  name   = "wordpress"
  region = "us-central1"
  settings {
    tier = "db-f1-micro"
  }

  deletion_protection  = "false"
}

resource "random_id" "db_name_suffix" {
  byte_length = 4
}

resource "google_sql_user" "users" {
  name     = "jishnn"
  instance = google_sql_database_instance.pokedex.name
  host     = "wordpress.com"
  password = "324b21"
}