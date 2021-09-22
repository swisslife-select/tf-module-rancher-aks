# Helm provider
provider "helm" {
  kubernetes {
    host = module.aks.host
    client_certificate     = base64decode(module.aks.client_certificate)
    client_key             = base64decode(module.aks.client_key)
    cluster_ca_certificate = base64decode(module.aks.cluster_ca_certificate)
  }
}

data "azurerm_resource_group" "subnet" {
  name = var.subnet_resource_group_name
}

data "azurerm_virtual_network" "vnet" {
  name                = var.subnet_virtual_network_name
  resource_group_name = var.subnet_resource_group_name
}

# grant network contributor role to aks principal for load balancers
resource "azurerm_role_assignment" "aks_to_vnet" {
  scope                = data.azurerm_virtual_network.vnet.id
  role_definition_name = "Network Contributor"
  principal_id         = module.aks.principal_id
}

# Install Rancher helm chart
resource "helm_release" "nginx-ingress" {
  timeout    = 120
  repository = "https://kubernetes.github.io/ingress-nginx/"
  name       = "nginx-stable"
  chart      = "ingress-nginx"
  version    = var.nginx_ingress_version
  namespace  = var.nginx_ingress_ns
  create_namespace = true
  wait_for_jobs = true

  set {
    name  = "controller.service.loadBalancerIP"
    value = "${var.lb_ip_address}"
  }

  values = ["${file("${path.module}/internal-load-balancer.yml")}"]

  depends_on = [module.aks, azurerm_role_assignment.aks_to_vnet]
}
