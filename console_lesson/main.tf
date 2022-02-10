terraform {
  required_version = ">= 1.0.11"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.5.0" 
    }
  }
}
resource "google_compute_instance" "web" {
  name = "terraform-vm"
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
  
  tags = ["web"]
}