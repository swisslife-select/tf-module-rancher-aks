output "rancher_endpoint" {
  description = "Rancher's HTTPS Endpoint"
  value = "https://rancher.${var.dns_zone_name}"
  depends_on = [
    null_resource.rancher_alive
  ]
}

output "aks" {
  value = module.aks
  depends_on = [
    module.aks,
    null_resource.rancher_alive
  ]
}

output "resource_group" {
  value = module.aks.resource_group
  depends_on = [
    module.aks,
    null_resource.rancher_alive
  ]
}
