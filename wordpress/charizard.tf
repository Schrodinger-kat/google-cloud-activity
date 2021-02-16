resource "google_compute_firewall" "charizard" {
  name          = "allow-incoming"
  network       = google_compute_network.pokenav.self_link
  direction     = "INGRESS"
  source_ranges = ["0.0.0.0/0"]
  
  allow {
    protocol = "all"
    ports    = []
  }
  allow {
    protocol = "tcp"
    ports = [
      "80", "8080", "443"
    ]
  }
    allow {
    protocol = "tcp"
    ports    = ["22"]
  }
}

resource "google_compute_firewall" "chansey" {
  name          = "allow-chansey"  
  network       = google_compute_network.pokenav.self_link
  source_ranges = ["35.191.0.0/16", "130.211.0.0/22"]

  allow {
    protocol = "tcp"
  }
}
