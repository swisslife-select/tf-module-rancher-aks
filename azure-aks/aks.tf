module "network" {
  source              = "Azure/network/azurerm"
  version             = "3.3.0"
  resource_group_name = azurerm_resource_group.rancher_aks.name
  address_space       = "10.0.0.0/16"
  subnet_prefixes     = ["10.0.0.0/20"]
  subnet_names        = ["rancher-subnet"]
  depends_on          = [azurerm_resource_group.rancher_aks]
}


module "aks" {
  source                           = "Azure/aks/azurerm"
  version                          = "4.8.0"
  resource_group_name              = azurerm_resource_group.rancher_aks.name
  client_id                        = ""
  client_secret                    = ""
  kubernetes_version               = var.aks_cluster_version
  orchestrator_version             = var.aks_cluster_version
  prefix                           = var.aks_name_prefix
  network_plugin                   = "azure"
  vnet_subnet_id                   = module.network.vnet_subnets[0]
  os_disk_size_gb                  = var.aks_node_disk_size
  sku_tier                         = "Paid" # defaults to Free
  enable_role_based_access_control = false
  rbac_aad_managed                 = false
  private_cluster_enabled          = true # default value
  enable_http_application_routing  = true
  enable_azure_policy              = true
  enable_auto_scaling              = true
  agents_min_count                 = var.aks_min_node_count
  agents_max_count                 = var.aks_max_node_count
  agents_count                     = null # Please set `agents_count` `null` while `enable_auto_scaling` is `true` to avoid possible `agents_count` changes.
  agents_max_pods                  = 100
  agents_pool_name                 = var.aks_agents_pool_name
  agents_availability_zones        = ["1", "2", "3"]
  agents_type                      = "VirtualMachineScaleSets"

  agents_labels = {
    "nodepool" : "rancher-node"
  }

  agents_tags = {
    "Agent" : "rancher-node"
  }

  network_policy                 = "azure"
  net_profile_dns_service_ip     = "10.1.0.10"
  net_profile_docker_bridge_cidr = "170.10.0.1/16"
  net_profile_service_cidr       = "10.1.0.0/16"

  depends_on = [module.network]
}
