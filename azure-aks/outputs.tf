
output "client_key" {
  description = "BASE64 encoded client key for use in KUBECONFIG"
  value = azurerm_kubernetes_cluster.main.kube_admin_config.0.client_key
}

output "client_certificate" {
  description = "BASE64 encoded client certificate for use in KUBECONFIG"
  value = azurerm_kubernetes_cluster.main.kube_admin_config.0.client_certificate
}

output "cluster_ca_certificate" {
  description = "BASE64 encoded Server CA Certificate for use in KUBECONFIG"
  value = azurerm_kubernetes_cluster.main.kube_admin_config.0.cluster_ca_certificate
}

output "host" {
  description = "Kube API Endpoint for use in KUBECONFIG"
  value = azurerm_kubernetes_cluster.main.kube_admin_config.0.host
}

output "principal_id" {
  description = "principal_id of the aks"
  value = azurerm_kubernetes_cluster.main.identity.0.principal_id
}
