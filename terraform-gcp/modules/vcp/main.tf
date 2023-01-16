resource "google_compute_firewall" "firewall_ssh" {
  name    = "allow-ssh-default"
  network = "default"
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  source_ranges = var.sourse_ranges
}
