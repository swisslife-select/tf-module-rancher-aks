output "rancher_endpoint" {
  description = "Rancher's HTTPS Endpoint"
  value = "https://rancher.${var.dns_zone_name}"
}
      
output "aks" {
  value = module.aks
  depends_on = [module.aks]
}
