terraform {
  required_version = ">= 1.0.11"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.5.0" 
    }
  }
  backend "gcs" {
      bucket = ""
      prefix = "terraform/main"
  }
}
provider "google" {
  project = ""
}
module "main_cluster" {
    source = "../modules/gke"
    name = "main-cluster"
    machine_type = "g1-small"
}