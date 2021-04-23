
output "client_key" {
  description = "BASE64 encoded client key for use in KUBECONFIG"
  value = module.aks.client_key
}

output "client_certificate" {
  description = "BASE64 encoded client certificate for use in KUBECONFIG"
  value = module.aks.client_certificate
}

output "cluster_ca_certificate" {
  description = "BASE64 encoded Server CA Certificate for use in KUBECONFIG"
  value = module.aks.cluster_ca_certificate
}

output "host" {
  description = "Kube API Endpoint for use in KUBECONFIG"
  value = module.aks.host
}