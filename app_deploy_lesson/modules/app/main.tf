variable "cluster_name" {}
variable "endpoint" {}
variable "ca_cert" {}
variable "location" {
  default = "us-central1"
}
variable "pod_name" {}
variable "image" {}
data "google_client_config" "provider" {}
provider "kubernetes" {
  host  = "https://${var.endpoint}"
  token = data.google_client_config.provider.access_token
  cluster_ca_certificate = base64decode(
    var.ca_cert,
  )
}
resource "kubernetes_pod" "sample_app" {
  metadata {
    name = var.pod_name
  }

  spec {
    container {
      image = var.image
      name  = "example"

      env {
        name  = "environment"
        value = "test"
      }

      port {
        container_port = 8080
      }

      liveness_probe {
        http_get {
          path = "/nginx_status"
          port = 80

          http_header {
            name  = "X-Custom-Header"
            value = "Awesome"
          }
        }

        initial_delay_seconds = 3
        period_seconds        = 3
      }
    }

    dns_config {
      nameservers = ["1.1.1.1", "8.8.8.8", "9.9.9.9"]
      searches    = ["example.com"]

      option {
        name  = "ndots"
        value = 1
      }

      option {
        name = "use-vc"
      }
    }

    dns_policy = "None"
  }
}