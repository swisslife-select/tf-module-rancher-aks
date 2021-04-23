provider "azurerm" {
  # Whilst version is optional, we /strongly recommend/ using it to pin the version of the Provider being used
  version = "=2.37.0"
  features{}
}

module "aks" {
    source = "./azure-aks"
    
    azure_location      = var.azure_location
    aks_name_prefix     = var.aks_name_prefix
    aks_cluster_version = var.aks_kubernetes_version
}

module "rancher_server" {
  source = "github.com/belgaied2/tf-module-rancher-server"
  rancher_k8s = {
    host                    = module.aks.host
    client_certificate      = base64decode(module.aks.client_certificate)
    client_key              = base64decode(module.aks.client_key)
    cluster_ca_certificate  = base64decode(module.aks.cluster_ca_certificate)
  }
  rancher_server = {
    ns = "cattle-system"
    version = var.rancher_version
    branch = "stable"
    chart_set = var.rancher_chart_options
  }
  rancher_hostname = "rancher.${var.dns_zone_name}"
}


