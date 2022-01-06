# Create a resource group
resource "azurerm_resource_group" "rancher_aks" {
  name     = "${var.name_prefix}-rancher-aks-rg"
  location = var.azure_location
}

data "azuread_service_principal" "client" {
  application_id = var.client_id
}

resource "azurerm_role_assignment" "client_rancher_aks" {
  scope                = azurerm_resource_group.rancher_aks.id
  role_definition_name = "Contributor"
  principal_id         = data.azuread_service_principal.client.id
  depends_on = [
    data.azuread_service_principal.client,
    azurerm_resource_group.rancher_aks
  ]
}
