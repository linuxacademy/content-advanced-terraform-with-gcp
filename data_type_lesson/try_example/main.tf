locals {
    users = jsondecode(file("roles.json"))

    bruce_role = try(local.users.Bruce, "No permissions Granted")
    diana_role = try(local.users.Diana, "No permissions Granted")
    clark_role = try(local.users.Clark, "No permissions Granted")

    hal_role = try(local.users.Hal, "No permissions Granted")
}

output "bruce" {
    value = local.bruce_role
}
output "diana" {
    value = local.diana_role
}
output "clark" {
    value = local.clark_role
}
output "hal" {
    value = local.hal_role
}