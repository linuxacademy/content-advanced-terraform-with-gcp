variable "name" {
  
}
variable "region" {
  default = "us-central1"
}
variable "machine_type" {
  default = "n2-standard-2"
}
variable "node_count" {
  default = 1
  type = number 
}
resource "google_service_account" "default" {
  account_id   = "service-account-id"
  display_name = "Service Account"
}
resource "google_container_cluster" "cluster" {
  name     = var.name
  location = var.region

  remove_default_node_pool = true
  initial_node_count       = 1
}
resource "google_container_node_pool" "nodes" {
  name       = "${var.name}-nodes"
  location   = var.region
  cluster    = google_container_cluster.cluster.name
  node_count = var.node_count

  node_config {
    preemptible  = true
    machine_type = var.machine_type
    service_account = google_service_account.default.email
    oauth_scopes    = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}
output "cluster_name" {
  value = google_container_cluster.cluster.name
}
output "endpoint" {
    value = google_container_cluster.cluster.endpoint
}
output "ca_cert" {
  value = google_container_cluster.cluster.master_auth[0].cluster_ca_certificate
}