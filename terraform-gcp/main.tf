provider "google" {
  project = var.project
  region  = var.region
}

module "app" {
  source           = "./modules/app"
  public_key_path  = var.public_key_path
  private_key_path = var.private_key_path
  app_disk_image   = var.app_disk_image
}
module "db" {
  source           = "./modules/db"
  public_key_path  = var.public_key_path
  private_key_path = var.private_key_path
  db_disk_image    = var.db_disk_image
}
module "vcp" {
  source = "./modules/vcp"
}

/*
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
      image = var.disk_image
    }
  }
  network_interface {
    network = "default"
    access_config {}
  }

  connection {
    host        = google_compute_instance.app.network_interface.0.access_config.0.nat_ip
    type        = "ssh"
    user        = "appuser"
    agent       = false
    private_key = file("${var.private_key_path}")
  }

  provisioner "remote-exec" {
    script = "files/deploy.sh"
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

resource "google_compute_firewall" "firewall_ssh" {
  name    = "allow-ssh-default"
  network = "default"
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["reddit-app"]
}
*/
