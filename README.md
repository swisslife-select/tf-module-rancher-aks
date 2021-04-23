# Introduction 
This repository is an example configuration for installing Rancher v2.5.X on AKS on Azure. 

# What this configuration creates
This configuration creates everything necessary for Rancher App on AKS:
1. A resource group
2. An EKS cluster with 3 nodes
3. Kubernetes pre-requisites to Rancher (Cert-manager and namespace)
4. Rancher installation using Helm
5. NGINX Ingress Controller
6. DNS Entries in an Azure Hosted Zone.

NOTE: This installation might fail in your environment because of Cloud configuration specificities. Please make sure to adapt the configuration to your environment.

# Technical Documentation


## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | =2.37.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | =2.37.0 |
| <a name="provider_helm"></a> [helm](#provider\_helm) | n/a |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_aks"></a> [aks](#module\_aks) | ./azure-aks |  |
| <a name="module_rancher_server"></a> [rancher\_server](#module\_rancher\_server) | github.com/belgaied2/tf-module-rancher-server |  |

## Resources

| Name | Type |
|------|------|
| [azurerm_dns_a_record.rancher_aks](https://registry.terraform.io/providers/hashicorp/azurerm/2.37.0/docs/resources/dns_a_record) | resource |
| [helm_release.nginx-ingress](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubernetes_service.nginx_host](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/data-sources/service) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aks_kubernetes_version"></a> [aks\_kubernetes\_version](#input\_aks\_kubernetes\_version) | Version of Rancher Management Cluster's Kubernetes | `string` | `"v1.20.5"` | no |
| <a name="input_aks_name_prefix"></a> [aks\_name\_prefix](#input\_aks\_name\_prefix) | Prefix to use for the cluster name | `string` | n/a | yes |
| <a name="input_azure_location"></a> [azure\_location](#input\_azure\_location) | Location to be used for the Resource Group | `string` | `"Germany West Central"` | no |
| <a name="input_dns_resource_group_name"></a> [dns\_resource\_group\_name](#input\_dns\_resource\_group\_name) | Resource Group Name for the DNS Entries | `string` | n/a | yes |
| <a name="input_dns_zone_name"></a> [dns\_zone\_name](#input\_dns\_zone\_name) | DNS Zone to host Rancher in | `string` | n/a | yes |
| <a name="input_nginx_ingress_ns"></a> [nginx\_ingress\_ns](#input\_nginx\_ingress\_ns) | Namespace where the NGINX Ingress Controller should be installed | `string` | `"ingress-nginx"` | no |
| <a name="input_nginx_ingress_version"></a> [nginx\_ingress\_version](#input\_nginx\_ingress\_version) | Version of NGINX Ingress Controller | `string` | `"3.29.0"` | no |
| <a name="input_rancher_chart_options"></a> [rancher\_chart\_options](#input\_rancher\_chart\_options) | List of options for the Rancher Helm Chat | <pre>list(object({<br>      name = string<br>      value = string<br>    }))</pre> | `[]` | no |
| <a name="input_rancher_version"></a> [rancher\_version](#input\_rancher\_version) | Version of Rancher Server to install | `string` | `"v2.5.7"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_rancher_endpoint"></a> [rancher\_endpoint](#output\_rancher\_endpoint) | Rancher's HTTPS Endpoint |


## Backend Configuration
You will notice that the `backend.tf` file does not contain actual configuration for the `http` backend. This is meant to use the [GitLab Terraform state](https://docs.gitlab.com/ee/user/infrastructure/terraform_state.html). Please check the file [gitlab_backend.example](./gitlab_backend.example) for a gitlab backend configuration template that you can fill with your settings and use using the command `terraform init -backend-config=gitlab_backend.example`.

You can also switch to the `azurerm` backend commented in the file or any other backend you would like to use.

# Feedback
Please review and test this configuration, then send any feedback to Mohamed : mohamed.belgaied@suse.com
