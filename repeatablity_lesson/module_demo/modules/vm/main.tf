variable "name" {
  description = "Name of VM in the console"
}
variable "machine" {
  default = "f1-micro"
  description = "Type of VM to be created"
}
resource "google_compute_instance" "web" {
  name = var.name
  machine_type = var.machine
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
