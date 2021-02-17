resource "google_compute_health_check" "autohealing" {
  name                = "autohealing-health-check"
  check_interval_sec  = 5
  timeout_sec         = 5
  healthy_threshold   = 2
  unhealthy_threshold = 10 # 50 seconds

  http_health_check {
    request_path = "/healthz"
    port         = "8080"
  }
}

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
  target_size        = 2

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
  target_size        = 2

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

resource "google_compute_region_autoscaler" "evo1" {
  name   = "hoenn-region-autoscaler"
  region = "us-east1"
  target = google_compute_region_instance_group_manager.mig_group1.id

  autoscaling_policy {
    max_replicas    = 3
    min_replicas    = 1
    cooldown_period = 60

    cpu_utilization {
      target = 0.5
    }
  }
}


resource "google_compute_region_autoscaler" "evo2" {
  name   = "kanto-region-autoscaler"
  region = "europe-west1"
  target = google_compute_region_instance_group_manager.mig_group2.id

  autoscaling_policy {
    max_replicas    = 3
    min_replicas    = 1
    cooldown_period = 60

    cpu_utilization {
      target = 0.5
    }
  }
}