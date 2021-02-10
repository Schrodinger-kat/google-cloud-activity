
provider "google" {
 credentials = file("SAKEY.json")
 project     = "gcp-training-01-303001"
 region      = "us-central1"
}

resource "google_compute_subnetwork" "jishnn-tf-sub" {
 name          = "jishnn-tf-sub"
 region        = "us-central1"
 ip_cidr_range = "10.20.0.0/24"
 network       = google_compute_network.jishnn-tf-vpc.self_link

}

resource "google_compute_network" "jishnn-tf-vpc" {
 name = "jishnn-tf-vpc"
 auto_create_subnetworks = "false"
 routing_mode = "REGIONAL"
}


resource "google_compute_firewall" "jishnn-tf-fw" {
  name    = "jishnn-tf-fw"
  network = google_compute_network.jishnn-tf-vpc.self_link

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_health_check" "hc" {
  name               = "proxy-health-check"
  check_interval_sec = 1
  timeout_sec        = 1

  tcp_health_check {
    port = "80"
  }
}

resource "google_compute_region_backend_service" "backend" {
  name          = "compute-backend"
  region        = "us-central1"
  health_checks = [google_compute_health_check.hc.id]
}

resource "google_compute_forwarding_rule" "default" {
  name     = "compute-forwarding-rule"
  region   = "us-central1"

  load_balancing_scheme = "INTERNAL"
  backend_service       = google_compute_region_backend_service.backend.id
  all_ports             = true
  network               = google_compute_network.jishnn-tf-vpc.self_link
  subnetwork            = google_compute_subnetwork.jishnn-tf-sub.self_link
}

resource "google_compute_route" "jishnn-tf-routes" {
  name        = "jishnn-tf-routes"
  dest_range  = "15.0.0.0/24"
  network     = google_compute_network.jishnn-tf-vpc.self_link
  next_hop_ilb = google_compute_forwarding_rule.default.id
  priority    = 100
}

resource "google_compute_instance" "jishnn-tf-cmi" {
  name         = "jishnn-tf-cmi"
  zone         ="us-central1-a"
  machine_type = "f1-micro"
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }
  network_interface {
    network = google_compute_network.jishnn-tf-vpc.self_link
    subnetwork  = google_compute_subnetwork.jishnn-tf-sub.self_link
    access_config {
    }
  }

}
