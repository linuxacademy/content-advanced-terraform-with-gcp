locals {

    content_data = jsondecode(file("${path.module}/content.json"))

    all_content = [for item in local.content_data.content : item.content_name]
}


output "content" {
    value = local.all_content
}