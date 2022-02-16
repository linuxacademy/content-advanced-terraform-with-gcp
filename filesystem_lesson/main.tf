terraform {
  required_version = ">= 1.0.11"
  required_providers {
    local = {
        source = "hashicorp/local"
        version = ">= 2.1.0"
    }
  }
}

locals {
    content_data = jsondecode(file("${path.module}/content.json"))
    all_content = [for item in local.content_data.content : item]
}

resource "local_file" "output" {
    filename = "./output.txt"
    content = templatefile("template.tftpl", { contents = local.all_content })
}
