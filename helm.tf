# Helm provider
provider "helm" {
  kubernetes {
    host = module.aks.host
    client_certificate     = base64decode(module.aks.client_certificate)
    client_key             = base64decode(module.aks.client_key)
    cluster_ca_certificate = base64decode(module.aks.cluster_ca_certificate)
  }
}



# Install Rancher helm chart
resource "helm_release" "nginx-ingress" {
  repository = "https://kubernetes.github.io/ingress-nginx/"
  name       = "nginx-stable"
  chart      = "ingress-nginx"
  version    = var.nginx_ingress_version
  namespace  = var.nginx_ingress_ns
  create_namespace = true

}
