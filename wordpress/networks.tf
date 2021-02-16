resource "google_compute_network" "pokenav" {
    name = "jishnn-tf-vpc"
    description = "vpc-name"
    auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "kanto" {
    name = "jishnn-sub1"
    region = "europe-west1"
    ip_cidr_range   = "10.0.1.0/24"
    network = google_compute_network.pokenav.name
    private_ip_google_access = true
    }


resource "google_compute_subnetwork" "hoenn" {
    name = "jishnn-sub2"
    region = "us-central1"
    ip_cidr_range   = "10.0.2.0/24"
    network = google_compute_network.pokenav.name
    private_ip_google_access = true
    }