# Create a resource group
resource "azurerm_resource_group" "rancher_aks" {
  name     = "${var.name_prefix}-rancher_aks"
  location = var.azure_location
}
