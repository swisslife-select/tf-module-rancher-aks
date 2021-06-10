# Create a resource group
resource "azurerm_resource_group" "rancher_aks" {
  name     = "${var.name_prefix}-rancher-aks"
  location = var.azure_location
}
