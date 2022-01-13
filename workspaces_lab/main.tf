resource "google_compute_instance" "web" {
  name = "web-server-${terraform.workspace}"
  machine_type = "f1-micro"
  zone = "us-central1-a"
  network_interface {
      network = "default"
      access_config {}
  }
  boot_disk {
      initialize_params {
          image = "debian-cloud/debian-9"
      }
  }
  metadata_startup_script = file("${path.module}/startup.sh")
  tags = ["web"]
}

resource "google_compute_firewall" "web-server" {
  name = "default-allow-http-${terraform.workspace}"
  network = "default"
  allow {
      protocol = "tcp"
      ports = ["80"]
  }
  source_ranges = ["0.0.0.0/0"]
  target_tags = ["web"]
}

output "web_server_ip" {
  value = google_compute_instance.web.*.network_interface.0.access_config.0.nat_ip
}