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
      
output "aks" {
  # Again, the value is not important because we're just
  # using this for its dependencies.
  value = {}

  # Anything that refers to this output must wait until
  # the actions for azurerm_monitor_diagnostic_setting.example
  # to have completed first.
  depends_on = [module.aks]
}
