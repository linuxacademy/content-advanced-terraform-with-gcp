
terraform {
  required_version = ">= 1.0.11"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.5.0" 
    }
    kubernetes = {
        source = "hashicorp/kubernetes"
        version = ">= 2.8.0"
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
module "sample_app" {
    source = "../modules/app"
    cluster_name = module.dev_cluster.cluster_name
    endpoint = module.dev_cluster.endpoint
    ca_cert = module.dev_cluster.ca_cert
    pod_name = "sample-app"
    image = "nginx:1.7.9"
}