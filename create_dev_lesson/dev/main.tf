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
      prefix = "terraform/dev"
  }
}
provider "google" {
  project = ""
}
module "dev_cluster" {
    source = "../modules/gke"
    name = "dev-cluster"
    machine_type = "g1-small"
}