resource "google_compute_instance_template" "gen1" {
  name = "jishnn-mig-tmp1"
  machine_type            = "n1-standard-1"
  metadata_startup_script = var.startup_script
  region                  = "us-east1"
  
  scheduling {
    automatic_restart = false
    preemptible       = true
  }

  disk {
    source_image = "debian-cloud/debian-9"
    auto_delete  = true
    boot         = true
  }

  network_interface {
    network    = google_compute_network.pokenav.self_link
    subnetwork = google_compute_subnetwork.hoenn.self_link
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "google_compute_instance_template" "gen2" {

  name = "jishnn-mig-tmp2"
  machine_type            = "n1-standard-1"
  metadata_startup_script = var.startup_script
  region                  = "europe-west1"
  
  scheduling {
    automatic_restart = false
    preemptible       = true
  }

  disk {
    source_image = "debian-cloud/debian-9"
    auto_delete  = true
    boot         = true
  }

  network_interface {
    network    = google_compute_network.pokenav.self_link
    subnetwork = google_compute_subnetwork.kanto.self_link
  }

  lifecycle {
    create_before_destroy = true
  }
}



resource "google_compute_region_instance_group_manager" "mig_group1" {
  name               = "jishnn-mig-g1"
  region             = "us-east1"
  base_instance_name = "jishnn-mig"
  target_size        = 1

  version {
    instance_template = google_compute_instance_template.gen1.self_link
    name              = "jishnn-gen1"
  }
  
  named_port {
    name = "http"
    port = 80
  }
  
  named_port {
    name = "https"
    port = 443
  }
}


resource "google_compute_region_instance_group_manager" "mig_group2" {
  name               = "jishnn-mig-g2"
  region             = "europe-west1"
  base_instance_name = "jishnn-mig"
  target_size        = 1

  version {
    instance_template = google_compute_instance_template.gen2.self_link
    name              = "jishnn-gen2"
  }
  
  named_port {
    name = "http"
    port = 80
  }
  
  named_port {
    name = "https"
    port = 443
  }
}
