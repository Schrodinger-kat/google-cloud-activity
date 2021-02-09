
provider "google" {
 credentials = file("")
 project     = var.gcp_project_id
 region      = var.region
}

resource "google_compute_network" "vpc" {
 name                    = var.vpc_name
 auto_create_subnetworks = "false"
}

resource "google_compute_subnetwork" "subnet" {
 name          = var.subnet_name
 ip_cidr_range = var.subnet_cidr
 network       = var.vpc_name
region        = var.region
}

resource "google_compute_firewall" "firewall" {
  name    = var.fw_name
  network = google_compute_network.vpc.vpc_name

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_route" "routes" {
  name        = var.route_name
  dest_range  = var.dest_range
  network     = google_compute_network.vpc.vpc_name
  next_hop_ip = var.next_hop_ip
  priority    = 100
}
resource "google_compute_instance" "vm_instance" {
  name         = var.vm_name
  machine_type = var.inst_type
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }
  network_interface {
    network = var.vpc_name
    access_config {
    }
  }

}
