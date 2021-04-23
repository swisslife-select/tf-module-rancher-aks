# Helm provider
provider "kubernetes" {
  
    host = module.aks.host
    client_certificate     = base64decode(module.aks.client_certificate)
    client_key             = base64decode(module.aks.client_key)
    cluster_ca_certificate = base64decode(module.aks.cluster_ca_certificate)
  
}

data "kubernetes_service" "nginx_host" {
    metadata {
        #name = "${helm_release.nginx-ingress.name}-${helm_release.nginx-ingress.chart}"
        name = "${helm_release.nginx-ingress.name}-${helm_release.nginx-ingress.chart}-controller"
        namespace = var.nginx_ingress_ns
    }
    depends_on = [
      helm_release.nginx-ingress
    ]
}

resource "azurerm_dns_a_record" "rancher_aks" {
  name                = "rancher"
  zone_name           = var.dns_zone_name
  resource_group_name = var.dns_resource_group_name
  ttl                 = 300
  records             = [ data.kubernetes_service.nginx_host.status.0.load_balancer.0.ingress.0.ip]
}

