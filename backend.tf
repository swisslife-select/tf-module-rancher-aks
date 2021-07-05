
# terraform{
#     backend "azurerm"{}
# }


terraform {
  backend "remote" {
    organization = "belgaied"

    workspaces {
      name = "aks-tenant-test"
    }
  }
}
