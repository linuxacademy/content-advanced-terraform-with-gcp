variable "env" {
  description = "The environment being provisioned"
  default = "default"
}
data "template_file" "index" {
    template = file("${path.module}/index.html")
    vars = {
        index_env = var.env
    }
}
resource "google_compute_instance" "web" {
  name = "web-server-${var.env}"
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
  metadata_startup_script = <<SCRIPT
    sudo apt-get update
    sudo apt-get install apache2 -y
    cat <<EOF > /var/www/html/index.html
    ${data.template_file.index.rendered}
  SCRIPT
  
  tags = ["web"]
}
resource "google_compute_firewall" "web-server" {
  name = "default-allow-http-${var.env}"
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
