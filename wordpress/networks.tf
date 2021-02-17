resource "google_compute_network" "pokenav" {
    name = "jishnn-tf-vpc"
    description = "vpc-name"
    auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "kanto" {
    name = "jishnn-sub1"
    region = "europe-west1"
    ip_cidr_range   = "10.0.1.0/24"
    network = google_compute_network.pokenav.self_link
    private_ip_google_access = true
    }


resource "google_compute_subnetwork" "hoenn" {
    name = "jishnn-sub2"
    region = "us-east1"
    ip_cidr_range   = "10.0.2.0/24"
    network = google_compute_network.pokenav.self_link
    private_ip_google_access = true
    }

resource "google_compute_router" "kanto_region_router" {
  name    = "euro-nat-gw"
  region  = google_compute_subnetwork.kanto.self_link
  network = google_compute_network.pokenav.self_link

  bgp {
    asn = 64514
  }
}

resource "google_compute_router" "hoenn_region_router" {
  name    = "usa-nat-gw"
  region  = google_compute_subnetwork.hoenn.self_link
  network = google_compute_network.pokenav.self_link

  bgp {
    asn = 64514
  }
}

resource "google_compute_router_nat" "kanto_gateway" {
  name                               = "europe-nat-gw"
  router                             = google_compute_router.kanto_region_router.self_link
  region                             = google_compute_subnetwork.kanto.self_link
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
}

resource "google_compute_router_nat" "hoenn_gateway" {
  name                               = "usa-nat-gw"
  router                             = google_compute_router.hoenn_region_router.self_link
  region                             = google_compute_subnetwork.hoenn.self_link
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
}