resource "google_compute_firewall" "charizard" {
  name          = "allow-incoming"
  network       = google_compute_network.pokenav.self_link
  direction     = "INGRESS"
  source_ranges = ["10.0.0.0/8"]
  
  allow {
    protocol = "all"
    ports    = []
    }
  }

  resource "google_compute_firewall" "nintendo_switch" {
  name        = "allow-iap-ssh"
  network     = google_compute_network.pokenav.self_link
  direction   = "INGRESS"
  target_tags = ["allow-iap-ssh"]

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = [
    "35.235.240.0/20"
  ]
}

resource "google_compute_firewall" "nintendo_global" {
  name          = "allow-http"
  network       = google_compute_network.pokenav.self_link
  direction     = "INGRESS"
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["allow-http"]

  allow {
    protocol = "tcp"
    ports = [
      "80", "8080", "443"
    ]
  }
}

resource "google_compute_firewall" "chansey" {
  name          = "allow-chansey"  
  network       = google_compute_network.pokenav.self_link
  direction     = "INGRESS"
  source_ranges = ["35.191.0.0/16", "130.211.0.0/22"]

  allow {
    protocol = "tcp"
  }
}
