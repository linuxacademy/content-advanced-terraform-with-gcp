terraform {
  required_version = ">= 1.0.11"
  required_providers {
    local = {
        source = "hashicorp/local"
        version = ">= 2.1.0"
    }
  }
}

variable "dangers" {
  default = ["lions", "tigers", "bears"]
  type = list
}

resource "local_file" "count" {
    count = length(var.dangers)
    filename = "./${var.dangers[count.index]}.txt"
    content = "${var.dangers[count.index]}, oh my!"
}

# resource "local_file" "for_each" {
#     for_each = toset(var.dangers)
#     filename = "./${each.value}.txt"
#     content = "${each.value}, oh my!"
# }