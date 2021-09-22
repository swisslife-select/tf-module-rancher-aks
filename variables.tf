## AZURE VARIABLES
# Variable for Resource Group Location
variable "azure_location" {
  type = string
  description = "Location to be used for the Resource Group"
  default = "Germany West Central"
}

# Variables related to DNS A Record creation
variable "dns_zone_name" {
  type = string
  description = "DNS Zone to host Rancher in"
}

variable "dns_resource_group_name" {
  type = string
  description = "Resource Group Name for the DNS Entries"
  
}

# Variables for AKS
variable "aks_name_prefix" {
  type = string
  description = "Prefix to use for the cluster name"
}


variable "aks_kubernetes_version" {
  type = string
  description = "Version of Rancher Management Cluster's Kubernetes"
  default = "1.20.5"
}

## RANCHER VARIABLES
# Variables for Rancher's Helm Release
variable "rancher_version" {
  type = string
  description = "Version of Rancher Server to install"
  default = "v2.5.7"
}

variable "rancher_chart_options" {
  type = list(object({
      name = string
      value = string
    }))
  description = "List of options for the Rancher Helm Chat"
  default = []
}

# Variables for Rancher's Ingress
variable "nginx_ingress_version" {
  type = string
  description = "Version of NGINX Ingress Controller"
  default = "3.29.0"
}

variable "nginx_ingress_ns" {
  type = string
  description = "Namespace where the NGINX Ingress Controller should be installed"
  default = "ingress-nginx"
}

variable "subnet_resource_group_name" {
  type = string
  description = "Resource Group of the vn for the subnet of the rancher cluster"
}

variable "subnet_virtual_network_name" {
  type = string
  description = "Name of the vn for the subnet of the rancher cluster"
}

variable "subnet_address_prefixes" {
  type = list(string)
  description = "the subnet prefixes"
}

variable "client_id" {
  description = "(Optional) The Client ID (appId) for the Service Principal used for the AKS deployment"
  type        = string
  default     = ""
}

variable "client_secret" {
  description = "(Optional) The Client Secret (password) for the Service Principal used for the AKS deployment"
  type        = string
  default     = ""
}

variable "lb_ip_address" {
  description = "IP address of the rancher clusters load_balancer"
  type = string
}
