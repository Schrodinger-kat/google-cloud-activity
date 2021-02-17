resource "google_sql_database_instance" "pokedex4" {
  name   = "jishnn-wpdb"
  region = "us-central1"
  settings {
    tier = "db-f1-micro"
  }

  deletion_protection  = "false"
}

resource "google_sql_database" "pss" {
  name     = "wordpressdb"
  instance = google_sql_database_instance.pokedex4.self_link
}

resource "random_id" "db_name_suffix" {
  byte_length = 4
}

resource "google_sql_user" "users" {
  name     = "jishnn"
  instance = google_sql_database_instance.pokedex4.self_link
  host     = "wordpress.com"
  password = "324b21"
}
