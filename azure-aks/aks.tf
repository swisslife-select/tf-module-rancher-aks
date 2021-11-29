resource "azurerm_subnet" "subnet" {
  name                 = "rancher-subnet"
  resource_group_name  = var.subnet_resource_group_name
  virtual_network_name = var.subnet_virtual_network_name
  address_prefixes     = var.subnet_address_prefixes
  enforce_private_link_endpoint_network_policies = true
}

<<<<<<< HEAD
module "aks" {
  source                           = "Azure/aks/azurerm"
  version                          = "4.8.0"
  resource_group_name              = azurerm_resource_group.rancher_aks.name
  client_id                        = var.client_id
  client_secret                    = var.client_secret
  kubernetes_version               = var.aks_cluster_version
  orchestrator_version             = var.aks_cluster_version
  prefix                           = var.aks_name_prefix
  network_plugin                   = "azure"
  vnet_subnet_id                   = azurerm_subnet.subnet.id
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

  depends_on = [azurerm_subnet.subnet]
=======
resource "tls_private_key" "ssh" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "azurerm_kubernetes_cluster" "main" {
  name                                = var.aks_name_prefix
  location                            = azurerm_resource_group.rancher_aks.location
  resource_group_name                 = azurerm_resource_group.rancher_aks.name
  dns_prefix                          = "swisslifeselect-${var.aks_name_prefix}"
  sku_tier                            = "Paid"
  private_cluster_enabled             = true
  private_dns_zone_id                 = "None"
  private_cluster_public_fqdn_enabled = true

  linux_profile {
    admin_username = var.admin_username

    ssh_key {
      # remove any new lines using the replace interpolation function
      key_data = replace(tls_private_key.ssh.public_key_openssh, "\n", "")
    }
  }

  default_node_pool {
    name                = var.aks_agents_pool_name
    type                = "VirtualMachineScaleSets"
    availability_zones  = ["1", "2", "3"]
    enable_auto_scaling = true
    max_count           = var.aks_max_node_count
    min_count           = var.aks_min_node_count
    vm_size             = "Standard_D2_v2"
    vnet_subnet_id      = azurerm_subnet.subnet.id
  }

  identity {
    type = "SystemAssigned"
  }

  addon_profile {
    http_application_routing {
      enabled = true
    }

    kube_dashboard {
      enabled = false
    }

    azure_policy {
      enabled = true
    }
  }
  role_based_access_control {
    enabled = true
  }

  network_profile {
    network_plugin     = "azure"
    dns_service_ip     = "10.1.0.10"
    docker_bridge_cidr = "170.10.0.1/16"
    service_cidr       = "10.1.0.0/16"
    load_balancer_sku  = "Standard"
  }

  depends_on = [
    azurerm_subnet.subnet
  ]
>>>>>>> e90ef9d (Got the private kube api running.)
}
