output "rancher_endpoint" {
  description = "Rancher's HTTPS Endpoint"
  value = "https://rancher.${var.dns_zone_name}"
}

output "aks_credentials" {
  description = "Credentials for aks k8s"
  value =  object({
    client_key = module.aks.client_key
    client_certificate = module.aks.client_certificate
    cluster_ca_certificate = module.aks.cluster_ca_certificate
    host = module.aks.host
 })
}
