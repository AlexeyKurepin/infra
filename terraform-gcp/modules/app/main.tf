resource "google_compute_instance" "app" {
  name         = "reddit-app"
  machine_type = "e2-small"
  zone         = "us-west4-b"
  tags         = ["reddit-app"]
  metadata = {
    sshKey = "appuser:${file("${var.public_key_path}")}"
  }
  boot_disk {
    initialize_params {
      image = var.app_disk_image
    }
  }
  network_interface {
    network = "default"
    access_config {}
  }
}

resource "google_compute_firewall" "firewall_puma" {
  name    = "allow-puma-default"
  network = "default"
  allow {
    protocol = "tcp"
    ports    = ["9292"]
  }
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["reddit-app"]
}
