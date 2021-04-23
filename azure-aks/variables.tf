variable "aks_name_prefix" {
  type = string
  description = "Prefix to use for the cluster name"
}


variable "aks_min_node_count" {
  type = number
  description = "Minimum Number of nodes for AKS"
  default = 3
  
}


variable "aks_max_node_count" {
  type = number
  description = "Maximum Number of nodes for AKS"
  default = 3
  
}

variable "aks_node_disk_size" {
  type = number
  description = "AKS Node Disk Size"
  default = 50
}

variable "aks_cluster_version" {
  type = string
  description = "Cluster version for AKS"
  default = "1.20.5"
}

variable "aks_agents_pool_name" {
  type = string
  description = "Node Pool Name for AKS"
  default = "rancher-nodes"
}


variable "name_prefix" {
  type = string
  description = "A name prefix for Azure resources to avoid same naming"
  default = "test"
}

variable "azure_location" {
  type = string
  description = "Location to be used for the Resource Group"
  default = "Germany West Central"
}