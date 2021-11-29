provider "azurerm" {
  # Whilst version is optional, we /strongly recommend/ using it to pin the version of the Provider being used
  version = "=2.37.0"
  features{}
}

module "aks" {
    source = "./azure-aks"

    azure_location      = var.azure_location
    aks_name_prefix     = var.aks_name_prefix
    name_prefix         = var.aks_name_prefix
    aks_cluster_version = var.aks_kubernetes_version
    client_id           = var.client_id
    client_secret       = var.client_secret
    admin_username      = var.admin_username
    subnet_resource_group_name  = var.subnet_resource_group_name
    subnet_virtual_network_name = var.subnet_virtual_network_name
    subnet_address_prefixes     = var.subnet_address_prefixes
}

module "rancher_server" {
  source = "github.com/swisslife-select/tf-module-rancher-server"
  rancher_k8s = {
    host                    = module.aks.host
    client_certificate      = base64decode(module.aks.client_certificate)
    client_key              = base64decode(module.aks.client_key)
    cluster_ca_certificate  = base64decode(module.aks.cluster_ca_certificate)
  }
  rancher_server = {
    ns = "cattle-system"
    version = var.rancher_version
    branch = var.rancher_branch
    chart_set = var.rancher_chart_options
  }
  rancher_hostname = "rancher.${var.dns_zone_name}"
}


