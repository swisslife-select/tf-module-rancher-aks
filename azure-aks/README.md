## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_aks"></a> [aks](#module\_aks) | Azure/aks/azurerm | 4.8.0 |
| <a name="module_network"></a> [network](#module\_network) | Azure/network/azurerm | 3.3.0 |

## Resources

| Name | Type |
|------|------|
| [azurerm_resource_group.rancher_aks](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aks_agents_pool_name"></a> [aks\_agents\_pool\_name](#input\_aks\_agents\_pool\_name) | Node Pool Name for AKS | `string` | `"rancher-nodes"` | no |
| <a name="input_aks_cluster_version"></a> [aks\_cluster\_version](#input\_aks\_cluster\_version) | Cluster version for AKS | `string` | `"1.20.5"` | no |
| <a name="input_aks_max_node_count"></a> [aks\_max\_node\_count](#input\_aks\_max\_node\_count) | Maximum Number of nodes for AKS | `number` | `3` | no |
| <a name="input_aks_min_node_count"></a> [aks\_min\_node\_count](#input\_aks\_min\_node\_count) | Minimum Number of nodes for AKS | `number` | `3` | no |
| <a name="input_aks_name_prefix"></a> [aks\_name\_prefix](#input\_aks\_name\_prefix) | Prefix to use for the cluster name | `string` | n/a | yes |
| <a name="input_aks_node_disk_size"></a> [aks\_node\_disk\_size](#input\_aks\_node\_disk\_size) | AKS Node Disk Size | `number` | `50` | no |
| <a name="input_azure_location"></a> [azure\_location](#input\_azure\_location) | Location to be used for the Resource Group | `string` | `"Germany West Central"` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | A name prefix for Azure resources to avoid same naming | `string` | `"test"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_client_certificate"></a> [client\_certificate](#output\_client\_certificate) | BASE64 encoded client certificate for use in KUBECONFIG |
| <a name="output_client_key"></a> [client\_key](#output\_client\_key) | BASE64 encoded client key for use in KUBECONFIG |
| <a name="output_cluster_ca_certificate"></a> [cluster\_ca\_certificate](#output\_cluster\_ca\_certificate) | BASE64 encoded Server CA Certificate for use in KUBECONFIG |
| <a name="output_host"></a> [host](#output\_host) | Kube API Endpoint for use in KUBECONFIG |
